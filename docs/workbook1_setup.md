# C++ TDD 환경구축

## 1. VSCODE 설치

- https://code.visualstudio.com/ 접속
- Windows > System Installer > x64 선택 > 다운로드 > msi 설치
- [Command Palette] Terminal: Select Default Profile > Command Prompt 선택
- [Extensions] C/C++ Extension Pack 설치 > Developer: Reload Window (또는 VSCODE 재실행)

## 2. MinGW-w64 설치

- https://code.visualstudio.com/docs/cpp/config-mingw
- https://www.mingw-w64.org/
- Downloads > Pre-built Toolchains > [WinLibs.com](https://winlibs.com/)
- GCC 15.2.0 (with POSIX threads) + MinGW-w64 14.0.0 (UCRT) - release 7
  - Win64 (without LLVM/Clang/LLD/LLDB): Zip archive > 다운로드
- `winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64ucrt-14.0.0-r7.zip` > `C:\mingw64` 압축 풀기
- [Win + R] > `sysdm.cpl` > 고급 > 환경 변수 > 시스템 변수 > Path > 편집
  - 새로 만들기 > `C:\mingw64\bin` > 확인
