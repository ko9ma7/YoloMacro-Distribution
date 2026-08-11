[CmdletBinding()]
param(
    [string]$PolicyPath = "activation/policy.json",
    [string]$OutputDirectory = "pages",
    [string]$PrivateKeyPath = ""
)

$ErrorActionPreference = "Stop"
$policy = Get-Content -LiteralPath $PolicyPath -Raw | ConvertFrom-Json
$published = [DateTimeOffset]::UtcNow
$expires = $published.AddDays([int]$policy.validForDays)

foreach ($product in $policy.products) {
    $arguments = @{
        Enabled = [bool]$product.enabled
        MinimumVersion = [string]$product.minimumVersion
        LatestVersion = [string]$product.latestVersion
        PublishedAt = $published
        ExpiresAt = $expires
        UpdateUrl = [string]$product.updateUrl
        ReleaseNotesUrl = [string]$product.releaseNotesUrl
        DllVersion = [string]$product.dllVersion
        DllSha256 = [string]$product.dllSha256
        ProductId = [string]$product.productId
        ChannelId = [string]$product.channelId
        OutputPath = Join-Path $OutputDirectory "activation/$($product.productId).json"
    }
    if ($PrivateKeyPath) { $arguments.PrivateKeyPath = $PrivateKeyPath }
    ./tools/Publish-ActivationManifest.ps1 @arguments
}
$legacy = $policy.products | Where-Object productId -eq $policy.legacyProductId | Select-Object -First 1
if ($null -eq $legacy) { throw "legacyProductId does not match a product." }
$legacyArguments = @{
    Enabled = [bool]$legacy.enabled
    MinimumVersion = [string]$legacy.minimumVersion
    LatestVersion = [string]$legacy.latestVersion
    PublishedAt = $published
    ExpiresAt = $expires
    UpdateUrl = [string]$legacy.updateUrl
    ReleaseNotesUrl = [string]$legacy.releaseNotesUrl
    DllVersion = [string]$legacy.dllVersion
    DllSha256 = [string]$legacy.dllSha256
    OutputPath = Join-Path $OutputDirectory "manifest.json"
}
if ($PrivateKeyPath) { $legacyArguments.PrivateKeyPath = $PrivateKeyPath }
./tools/Publish-ActivationManifest.ps1 @legacyArguments

$activationDirectory = Join-Path $OutputDirectory "activation"
New-Item -ItemType Directory -Path $activationDirectory -Force | Out-Null
Copy-Item -LiteralPath "activation/public-key.pem" -Destination (Join-Path $activationDirectory "public-key.pem") -Force
Copy-Item -LiteralPath $PolicyPath -Destination (Join-Path $activationDirectory "policy.json") -Force
if (Test-Path -LiteralPath "activation/history.json") {
    Copy-Item -LiteralPath "activation/history.json" -Destination (Join-Path $activationDirectory "channel-history.json") -Force
}
