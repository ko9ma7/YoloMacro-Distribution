# VisionFlow Studio 2.7.1

2.7.1은 VisionFlow Studio의 기존 UI, 프로젝트 형식, OpenCV 5 인식과 2.7.0의 자연스러운 입력 경로를 유지하면서 장시간 실행과 재시작의 실패 경계를 보완한 패치 릴리스입니다.

## 실행 안정성

- Stop은 취소 요청만 보내고 끝나지 않고 프레임·템플릿·OpenCV 상태 정리가 완료될 때까지 기다립니다.
- 정리 중에는 Run과 Stop을 잠그며, 완료 후에만 다시 실행할 수 있습니다.
- 중복 Start는 새 엔진을 겹쳐 만들지 않고 현재 실행 작업을 공유합니다.
- 각 실행은 저장된 체크 구성에서 `RuntimeChecked`를 다시 만들기 때문에 이전 분기가 다음 실행의 이미지 항목을 비활성으로 남기지 않습니다.

## 비활성 입력과 대상 창

- Interception이 준비된 경우에만 드라이버 입력을 사용합니다.
- 비활성 모드에서 드라이버를 사용할 수 없으면 실제 커서로 전환하지 않고 `PostMessage`를 유지합니다.
- 전역 활성 모드 또는 액션의 실제 커서 강제를 명시한 경우에만 전면 입력 대체를 허용합니다.
- 실행 전에 저장된 제목, 프로세스, 창 클래스와 자식 오프셋으로 대상 HWND를 다시 찾습니다.
- 실행 중 실제 입력 HWND가 재생성되면 잘못된 창에 입력하지 않고 안전 정지하며 다음 실행에서 자동 재연결합니다.

## 패키지와 출처

- 실행 ZIP: [`VisionFlow-Studio-v2.7.1-win-x64.zip`](../releases/visionflow-studio/2.7.1/VisionFlow-Studio-v2.7.1-win-x64.zip)
- SHA-256: [`VisionFlow-Studio-v2.7.1-win-x64.zip.sha256`](../releases/visionflow-studio/2.7.1/VisionFlow-Studio-v2.7.1-win-x64.zip.sha256)
- 빌드 manifest: [`VisionFlow-Studio-v2.7.1-win-x64.manifest.json`](../releases/visionflow-studio/2.7.1/VisionFlow-Studio-v2.7.1-win-x64.manifest.json)
- 기준 소스: [`ko9ma7/VisionFlow-Studio`](https://github.com/ko9ma7/VisionFlow-Studio)

배포 폴더에는 소스 코드를 복사하지 않고 Windows x64 실행 패키지, CoreLib, 무결성 해시와 빌드 출처만 둡니다. ZIP 전체를 새 폴더에 풀어 사용하며 이전 설치에 DLL 일부만 덮어쓰지 않습니다.

## 검증

- Release 빌드: 경고 0, 오류 0
- 실행 수명 주기·비활성 입력 회귀: 4/4
- 대상 추적·이미지 매칭: 14/14
- 보안·업데이터: 18/18
- 패키지 EXE: 버전 2.7.1, 메인 창 응답과 정상 종료 확인

서명된 웹 실행 정책과 GitHub Release는 Distribution의 관리 Action에서 2.7.1 CoreLib SHA-256으로 별도 게시해야 합니다. 저장소의 기존 `activation/visionflow-studio.json`은 유효한 서명을 보존하기 위해 로컬 커밋에서 임의 수정하지 않습니다.
