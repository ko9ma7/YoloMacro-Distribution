# YoloMacro 메모리 모니터

YoloMacro의 메모리 모니터는 매크로 실행 중 대상 프로세스의 지정 값을 읽고 `{memory.key}` 형식의 런타임 토큰으로 제공합니다.

이 기능은 읽기 전용입니다. 대상 프로세스에 패치하거나 값을 쓰지 않고 Windows `ReadProcessMemory` API만 사용합니다.

## 설정 순서

1. `환경 설정`을 엽니다.
2. `메모리 모니터` 옵션을 켭니다.
3. 프로필 JSON 경로를 지정하거나 `예제 생성` 버튼으로 `MemoryProfile.json`을 만듭니다.
4. `프로필 열기`로 JSON을 열고 읽을 값의 `Key`, `Address`, `PointerOffsets`, `Type`을 채웁니다.
5. 매크로를 실행합니다.
6. `스냅샷 열기`로 `Memory/MemorySnapshot.json`을 확인합니다.
7. 메시지, 키 입력, 커스텀 스크립트에서 `{memory.<key>}` 토큰을 사용합니다.

`예제 생성`을 누르면 같은 폴더에 `MemoryProfile.guide.md`도 같이 생성됩니다. 주소를 처음 찾는 경우에는 이 가이드를 열어 `Address`, `PointerOffsets`, `Type`을 어떤 순서로 채워야 하는지 확인하세요.

## 프로필 예시

```json
{
  "Enabled": true,
  "ProcessName": "",
  "ModuleName": "GameAssembly.dll",
  "PollIntervalMs": 200,
  "WriteSnapshotFile": true,
  "Watches": [
    {
      "Key": "player.hp",
      "Address": "0x123456",
      "PointerOffsets": ["0x10", "0x20"],
      "Type": "Int32"
    }
  ]
}
```

`ProcessName`이 비어 있으면 현재 지정된 대상 창을 소유한 프로세스를 읽습니다.

`ModuleName`이 비어 있으면 대상 프로세스의 메인 모듈을 주소 기준으로 사용합니다.

`Address`는 모듈 기준 상대 주소입니다.

```text
실제 시작 주소 = moduleBase + Address
```

포인터 오프셋은 아래 순서로 해석합니다.

```text
moduleBase + Address
  -> pointer 읽기 후 PointerOffsets[0] 더하기
  -> pointer 읽기 후 PointerOffsets[1] 더하기
  -> 최종 값 읽기
```

`PointerOffsets`가 없으면 `moduleBase + Address`에서 값을 직접 읽습니다.

## 값을 찾는 기본 방식

YoloMacro는 대상 프로세스에 값을 쓰지 않고 읽기만 합니다. 주소 자체를 자동으로 확정하려면 대상 프로그램의 구조를 알아야 하므로, 기본 흐름은 아래처럼 사용합니다.

1. 타겟 창을 지정합니다.
2. `MemoryProfile.json`에 후보 주소를 넣습니다.
3. 매크로를 실행합니다.
4. `스냅샷 열기`로 `Memory/MemorySnapshot.json`을 확인합니다.
5. 값이 맞으면 `{memory.key}` 토큰으로 사용합니다.
6. 값이 비거나 오류가 있으면 스냅샷의 `Errors`에서 실패 주소, 모듈, 포인터 체인을 확인합니다.

자주 쓰는 시작점:

- 단순 숫자: `PointerOffsets`를 비우고 `Int32`, `Float`부터 확인
- Unity/IL2CPP 문자열: `Il2CppStringPointer`
- 포인터 체인: 기준 주소를 `Address`, 단계별 오프셋을 `PointerOffsets`에 순서대로 입력
- 현재 읽힌 실제 주소 확인: `{memory.<key>.address}`

## 런타임 토큰

프로필에 `"Key": "player.hp"`가 있으면 매크로 실행 중 아래 토큰을 사용할 수 있습니다.

```text
{memory.player.hp}
```

각 Watch는 실제로 해석된 주소도 함께 제공합니다.

```text
{memory.player.hp.address}
```

`WriteSnapshotFile`이 켜져 있으면 최신 값은 프로젝트 폴더의 아래 파일에 저장됩니다.

```text
Memory/MemorySnapshot.json
```

## 지원 자료형

- `Int32`
- `UInt32`
- `Int64`
- `UInt64`
- `Float`
- `Double`
- `Bool`
- `Pointer`
- `Utf16String`
- `Utf16StringPointer`
- `Il2CppString`
- `Il2CppStringPointer`
- `AnsiString`
- `AnsiStringPointer`

Unity IL2CPP 대상에서 최종 주소가 `Il2CppString*`를 담고 있으면 `Il2CppStringPointer`를 사용합니다. 문자열 길이는 `+0x10`, UTF-16 문자 배열은 `+0x14`에서 읽습니다.

## 정지 안정화

버전 `1.0.2`부터 `StartAsync()`와 `StopAsync()`는 동일한 생명주기 잠금으로 직렬화됩니다. 따라서 아래 상황에서도 동일 자원을 두 번 해제하지 않습니다.

- 사용자가 시작 직후 바로 정지를 누르는 경우
- 정지 버튼과 엔진 종료 콜백이 동시에 들어오는 경우
- 메모리 모니터가 꺼진 상태에서 `StopAsync()`가 반복 호출되는 경우

프로필의 `Watches`가 누락된 경우도 빈 목록으로 처리해 실행 중 예외 대신 안내 메시지를 남깁니다.

## YOLO26 참고

기본 모델 경로는 `yolo26n.onnx`입니다. Ultralytics YOLO26 모델은 ONNX로 내보낸 뒤 사용할 수 있지만, 이 앱은 기존 .NET YOLO 런타임으로 ONNX를 읽습니다. 실제 실행 전 `YOLO 모델` 메뉴에서 모델 로드가 정상인지 먼저 확인하세요.
