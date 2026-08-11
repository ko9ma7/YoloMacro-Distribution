[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][bool]$Enabled,
    [Parameter(Mandatory = $true)][string]$MinimumVersion,
    [Parameter(Mandatory = $true)][string]$LatestVersion,
    [Parameter(Mandatory = $true)][DateTimeOffset]$PublishedAt,
    [Parameter(Mandatory = $true)][DateTimeOffset]$ExpiresAt,
    [Parameter(Mandatory = $true)][string]$UpdateUrl,
    [Parameter(Mandatory = $true)][string]$ReleaseNotesUrl,
    [Parameter(Mandatory = $true)][string]$DllVersion,
    [Parameter(Mandatory = $true)][string]$DllSha256,
    [Parameter(Mandatory = $true)][string]$OutputPath,
    [string]$ProductId = "",
    [string]$ChannelId = "",
    [string]$PrivateKeyPath = ""
)

$ErrorActionPreference = "Stop"
if ($PSVersionTable.PSVersion.Major -lt 7) { throw "PowerShell 7 or newer is required." }

function Test-TrustedUrl([string]$Value) {
    $uri = [Uri]$Value
    if ($uri.Scheme -ne "https" -or $uri.UserInfo) { return $false }
    $allowed = @("github.com", "api.github.com", "objects.githubusercontent.com", "raw.githubusercontent.com", "githubusercontent.com", "ko9ma7.github.io")
    foreach ($hostName in $allowed) {
        if ($uri.IdnHost -eq $hostName -or $uri.IdnHost.EndsWith(".$hostName", [StringComparison]::OrdinalIgnoreCase)) { return $true }
    }
    return $false
}

if ($ExpiresAt -le $PublishedAt) { throw "ExpiresAt must be later than PublishedAt." }
if ($DllSha256 -notmatch "^[0-9a-fA-F]{64}$") { throw "DllSha256 must contain 64 hexadecimal characters." }
if (-not (Test-TrustedUrl $UpdateUrl) -or -not (Test-TrustedUrl $ReleaseNotesUrl)) { throw "Only approved GitHub HTTPS URLs are allowed." }

$privatePem = if ($PrivateKeyPath) { Get-Content -LiteralPath $PrivateKeyPath -Raw } else { $env:ACTIVATION_SIGNING_KEY_PEM }
if ([string]::IsNullOrWhiteSpace($privatePem)) { throw "Provide PrivateKeyPath or ACTIVATION_SIGNING_KEY_PEM." }

$published = $PublishedAt.ToUniversalTime().ToString("O")
$expires = $ExpiresAt.ToUniversalTime().ToString("O")
$normalizedHash = $DllSha256.ToLowerInvariant()
$schemaVersion = if (-not [string]::IsNullOrWhiteSpace($ChannelId)) { 3 } elseif (-not [string]::IsNullOrWhiteSpace($ProductId)) { 2 } else { 1 }
$canonicalLines = @("schemaVersion=$schemaVersion")
if ($schemaVersion -ge 2) { $canonicalLines += "productId=$($ProductId.Trim().ToLowerInvariant())" }
if ($schemaVersion -eq 3) { $canonicalLines += "channelId=$($ChannelId.Trim())" }
$canonicalLines += @(
    "enabled=$($Enabled.ToString().ToLowerInvariant())"
    "minimumVersion=$($MinimumVersion.Trim())"
    "latestVersion=$($LatestVersion.Trim())"
    "publishedAt=$published"
)
if ($schemaVersion -ne 3) { $canonicalLines += "expiresAt=$expires" }
$canonicalLines += @(
    "updateUrl=$($UpdateUrl.Trim())"
    "releaseNotesUrl=$($ReleaseNotesUrl.Trim())"
    "dllVersion=$($DllVersion.Trim())"
    "dllSha256=$normalizedHash"
)
$canonical = $canonicalLines -join "`n"

$signer = [System.Security.Cryptography.ECDsa]::Create()
try {
    $signer.ImportFromPem($privatePem)
    $signatureBytes = $signer.SignData(
        [Text.Encoding]::UTF8.GetBytes($canonical),
        [Security.Cryptography.HashAlgorithmName]::SHA256,
        [Security.Cryptography.DSASignatureFormat]::IeeeP1363FixedFieldConcatenation)
} finally {
    $signer.Dispose()
    $privatePem = $null
}

$manifest = [ordered]@{ schemaVersion = $schemaVersion }
if ($schemaVersion -ge 2) { $manifest.productId = $ProductId.Trim().ToLowerInvariant() }
if ($schemaVersion -eq 3) { $manifest.channelId = $ChannelId.Trim() }
$manifest += [ordered]@{
    enabled = $Enabled
    minimumVersion = $MinimumVersion.Trim()
    latestVersion = $LatestVersion.Trim()
    publishedAt = $published
}
if ($schemaVersion -ne 3) { $manifest.expiresAt = $expires }
$manifest += [ordered]@{
    updateUrl = $UpdateUrl.Trim()
    releaseNotesUrl = $ReleaseNotesUrl.Trim()
    dllVersion = $DllVersion.Trim()
    dllSha256 = $normalizedHash
    signature = [Convert]::ToBase64String($signatureBytes)
}

$parent = Split-Path -Parent $OutputPath
if ($parent) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
$temporary = "$OutputPath.tmp"
[IO.File]::WriteAllText($temporary, ($manifest | ConvertTo-Json -Depth 3), [Text.UTF8Encoding]::new($false))
Move-Item -LiteralPath $temporary -Destination $OutputPath -Force
Write-Output "Signed activation manifest written to $OutputPath"
