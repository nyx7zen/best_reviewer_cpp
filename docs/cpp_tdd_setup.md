# C++ TDD 환경구축 정리

## 1. 설치 목록

| 구분 | 프로그램 | 버전 | 다운로드 | 역할 |
|---|---|---|---|---|
| IDE | Visual Studio Code | 최신 | code.visualstudio.com | 코드 작성, 빌드, 디버깅 통합 환경 |
| 컴파일러 | MinGW-w64 (GCC/G++/GDB) | GCC 15.2.0, POSIX | winlibs.com | C++ 소스 컴파일 및 디버깅 |
| 빌드 도구 | CMake | 4.x | cmake.org/download | 멀티파일 프로젝트 빌드 관리 |
| 테스트 프레임워크 | GoogleTest | v1.16.0 | github.com/google/googletest | C++ 단위 테스트 프레임워크 |
| 패키지 관리자 | Chocolatey | 최신 | chocolatey.org/install | Windows 패키지 관리자 (lcov 설치용) |
| 커버리지 수집 | lcov | 최신 | choco install lcov | gcov 데이터를 lcov.info 로 변환 |
| lcov 실행 환경 | Strawberry Perl | 최신 | strawberryperl.com | lcov 실행에 필요한 Perl 런타임 |
| 정적 분석 | Cppcheck | 최신 | cppcheck.sourceforge.io | 코드 정적 분석 |
| 버전 관리 | Git | 최신 | git-scm.com/downloads | 소스 이력 관리 및 GitHub 연동 |

---

## 2. VSCode Extension 설치 목록

| Extension | 설치 방법 | 역할 |
|---|---|---|
| C/C++ Extension Pack | Ctrl+Shift+X → C++ 검색 → 설치 | 아래 4개 한 번에 설치 |
| - C/C++ | 위 팩에 포함 | IntelliSense, 자동완성, 디버그 UI |
| - CMake | 위 팩에 포함 | CMakeLists.txt IntelliSense |
| - CMake Tools | 위 팩에 포함 | 상태바 빌드/실행/디버그 원클릭 |
| - C++ TestMate | 위 팩에 포함 | GoogleTest UI 트리뷰 표시 |
| GitLens | 별도 검색 설치 | 커밋 그래프, 인라인 Blame |
| Git History | 별도 검색 설치 | 커밋 목록 및 파일 변경 내역 비교 |
| C/C++ Advanced Lint | 별도 검색 설치 | Cppcheck VSCode 연동 |
| Coverage Gutters | 별도 검색 설치 | lcov.info 기반 커버리지 에디터 인라인 표시 |

---

## 3. 환경변수 PATH 등록

| 항목 | 경로 | 등록 방법 |
|---|---|---|
| MinGW-w64 | `C:\mingw64\bin` | 수동 등록 |
| CMake | 자동 등록 | 설치 시 "Add CMake to the system PATH" 선택 |
| Chocolatey | `C:\ProgramData\chocolatey\bin` | 설치 스크립트가 자동 등록 |
| Strawberry Perl | 자동 등록 | 설치 시 자동으로 PATH 등록 |
| Cppcheck | 설치 경로\bin | 수동 등록 |

### MinGW-w64 PATH 등록 방법
```
Win + R → sysdm.cpl → 고급 → 환경변수 → 시스템변수 Path → 편집 → 새로만들기
C:\mingw64\bin 입력 → 확인
```

### 설치 확인 명령어
```cmd
gcc -v
g++ -v
gdb --version
cmake --version
git --version
cppcheck --version
choco --version
perl -v
lcov --version
```

---

## 4. 프로젝트 폴더 구조

### 인터넷 연결 가능한 경우 — FetchContent 방식

```
프로젝트루트\
  include\
    Xxx.h              <- 클래스 선언 헤더
  src\
    Xxx.cpp            <- 구현 코드
    main.cpp           <- 실행 진입점
  tests\
    XxxTest.cpp        <- GoogleTest 단위 테스트
  CMakeLists.txt       <- 빌드 설정
  .gitignore           <- Git 제외 항목
```

최초 빌드 시 googletest 를 자동으로 다운로드합니다. 별도 폴더 복사가 불필요합니다.

### 인터넷 연결 불가한 경우 — external 방식

```
프로젝트루트\
  include\
    Xxx.h              <- 클래스 선언 헤더
  src\
    Xxx.cpp            <- 구현 코드
    main.cpp           <- 실행 진입점
  tests\
    XxxTest.cpp        <- GoogleTest 단위 테스트
  external\
    googletest-1.16.0\ <- 미리 다운로드한 GoogleTest 소스
      CMakeLists.txt   <- 이 파일이 반드시 존재해야 함
      googletest\
      googlemock\
  CMakeLists.txt       <- 빌드 설정
  .gitignore           <- Git 제외 항목
```

github.com/google/googletest/releases 에서 미리 zip 을 다운로드한 뒤 압축 해제하여 `external` 폴더 아래에 복사합니다.

폴더 구조 확인 시 `external\googletest-1.16.0\CMakeLists.txt` 파일이 반드시 존재해야 합니다. 압축 해제 시 폴더가 중첩되는 경우가 있으므로 반드시 확인합니다.

```cmd
dir C:\DEV\프로젝트루트\external\googletest-1.16.0
```

---

## 5. CMakeLists.txt 기본 템플릿

### 인터넷 연결 가능한 경우 — FetchContent 방식

```cmake
cmake_minimum_required(VERSION 3.14)

project(프로젝트명 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include)

# 메인 실행파일
add_executable(앱이름
    src/main.cpp
    src/Xxx.cpp
)

# GoogleTest — FetchContent 방식 (자동 다운로드)
include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.16.0.zip
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# 테스트 실행파일
add_executable(XxxTest
    tests/XxxTest.cpp
    src/Xxx.cpp
)

target_link_libraries(XxxTest gtest_main)
target_include_directories(XxxTest PRIVATE include)

# 커버리지 옵션
target_compile_options(XxxTest PRIVATE --coverage)
target_link_options(XxxTest PRIVATE --coverage)

enable_testing()
add_test(NAME XxxTest COMMAND XxxTest)
```

### 인터넷 연결 불가한 경우 — external 방식

```cmake
cmake_minimum_required(VERSION 3.10...3.28)

project(프로젝트명 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include)

# 메인 실행파일
add_executable(앱이름
    src/main.cpp
    src/Xxx.cpp
)

# GoogleTest — external 방식 (로컬 소스 사용)
add_subdirectory(external/googletest-1.16.0)

# 테스트 실행파일
add_executable(XxxTest
    tests/XxxTest.cpp
    src/Xxx.cpp
)

target_link_libraries(XxxTest gtest_main)
target_include_directories(XxxTest PRIVATE include)

# 커버리지 옵션
target_compile_options(XxxTest PRIVATE --coverage)
target_link_options(XxxTest PRIVATE --coverage)

enable_testing()
add_test(NAME XxxTest COMMAND XxxTest)
```

### 두 방식 비교

| 항목 | FetchContent 방식 | external 방식 |
|---|---|---|
| 인터넷 연결 | 최초 빌드 시 필요 | 불필요 |
| CMake 최소 버전 | 3.14 | 3.10 |
| googletest 폴더 | 불필요 | `external/googletest-1.16.0/` 필요 |
| 키워드 | `FetchContent_Declare`, `FetchContent_MakeAvailable` | `add_subdirectory` |
| 빌드 속도 (최초) | 다운로드 시간 추가 | 즉시 빌드 |
| 사내 망 분리 환경 | 사용 불가 | 사용 가능 |

---

## 6. .gitignore 기본 템플릿

```
/build/
*.exe
*.o
*.a
.vscode/
# external 폴더는 커밋에 포함 (인터넷 불가 환경에서 필요)
# external/
```

---

## 7. 최초 빌드 명령어

CMakeLists.txt 작성 완료 후 1회만 실행합니다.

```cmd
cd 프로젝트루트
cmake -S . -B build -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=C:\mingw64\bin\g++.exe
```

---

## 8. Configure 재실행이 필요한 경우

| 상황 | 필요 여부 |
|---|---|
| CMakeLists.txt 수정 | 필요 |
| build 폴더 삭제 후 재시작 | 필요 |
| 새 소스 파일을 CMakeLists.txt 에 추가 | 필요 |
| .cpp / .h 소스 파일 내용만 수정 | 불필요 |

### build 폴더 삭제 후 재빌드

```cmd
cd 프로젝트루트
rmdir /s /q build
cmake -S . -B build -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=C:\mingw64\bin\g++.exe
cmake --build build
```

---

## 9. Git 초기화 및 GitHub Push

```cmd
cd 프로젝트루트
git init
git add .
git commit -m "feat: 초기 커밋"
git remote add origin https://github.com/계정명/저장소명.git
git branch -M main
git push -u origin main
```

### remote origin 이미 존재할 경우

```cmd
git remote remove origin
git remote add origin https://github.com/계정명/저장소명.git
git remote -v
git push -u origin main
```

### 이후 커밋 및 Push

```cmd
git add .
git commit -m "feat: 커밋 메시지"
git push
```

---

## 10. 핵심 단축키

| 단축키 | 기능 |
|---|---|
| F5 | 디버그 시작 |
| F7 | CMake 빌드 |
| Shift+F5 | CMake 디버그 실행 |
| F9 | 중단점 설정/해제 |
| F10 | Step Over |
| F11 | Step Into |
| Ctrl+Shift+P | Command Palette |
| Ctrl+Shift+X | Extensions |
| Ctrl+Shift+G | Source Control (Git) |
| Ctrl+Shift+M | Problems 탭 |
| Ctrl+` | 터미널 열기 |

---

## 11. Chocolatey 설치 (PowerShell 관리자 권한)

PowerShell 을 관리자 권한으로 실행 후 아래 명령어를 실행합니다.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

설치 확인:
```cmd
choco --version
```

---

## 12. Strawberry Perl 설치

strawberryperl.com 에서 설치파일 다운로드 후 Next → Next 로 설치합니다. PATH 가 자동으로 등록됩니다.

설치 확인:
```cmd
perl -v
```

---

## 13. lcov 설치 및 설정

### lcov 설치 (PowerShell 관리자 권한)
```cmd
choco install lcov -y
```

### lcov.bat 파일 생성 (PowerShell 관리자 권한)

`C:\ProgramData\chocolatey\bin\lcov.bat` 파일을 생성하고 아래 내용을 작성합니다.

```bat
@echo off
perl "C:\ProgramData\chocolatey\lib\lcov\tools\bin\lcov" %*
```

설치 확인:
```cmd
lcov --version
```

---

## 14. Coverage Gutters VSCode 설정

### .vscode 폴더 및 settings.json 생성

VSCode 터미널에서 프로젝트 루트에 `.vscode` 폴더와 `settings.json` 파일을 생성합니다.

```cmd
cd 프로젝트루트
mkdir .vscode
```

VSCode Explorer 에서 `.vscode` 폴더 아래 `settings.json` 파일을 New File 로 생성하고 아래 내용을 작성합니다.

```json
{
  "coverage-gutters.lcovname": "build/lcov.info"
}
```

### 최종 폴더 구조

```
프로젝트루트\
  .vscode\
    settings.json    <- coverage-gutters lcov.info 경로 설정
  include\
  src\
  tests\
  CMakeLists.txt
  .gitignore
```

### .gitignore 에 .vscode 추가 여부

| 상황 | .gitignore 처리 |
|---|---|
| 팀 프로젝트 | `.vscode/` 를 .gitignore 에 추가 (개인 설정이므로) |
| 혼자 사용 | `.vscode/` 를 커밋에 포함해도 무방 |

---

## 15. 테스트 커버리지 확인 절차

### 전제 조건

CMakeLists.txt 에 `--coverage` 옵션이 추가되어 있어야 합니다.

```cmake
target_compile_options(XxxTest PRIVATE --coverage)
target_link_options(XxxTest PRIVATE --coverage)
```

### 커버리지 확인 명령어 순서

**1. 테스트 실행 — .gcda 파일 생성**
```cmd
cd 프로젝트루트\build
ctest --output-on-failure
```

테스트 실행 시 `.gcda` 파일이 자동으로 생성됩니다. `.gcda` 파일은 어떤 코드가 실행되었는지 기록하는 커버리지 원시 데이터입니다.

**2. .gcda 파일 생성 확인**
```cmd
cd 프로젝트루트\build
dir /s *.gcda
```

정상이면 아래처럼 출력됩니다:
```
CMakeFiles\XxxTest.dir\src\Xxx.cpp.gcda
CMakeFiles\XxxTest.dir\tests\XxxTest.cpp.gcda
```

파일이 없으면 CMakeLists.txt 에 `--coverage` 옵션이 누락된 것입니다.

**3. lcov 커버리지 수집 — lcov.info 생성**
```cmd
cd 프로젝트루트
lcov --capture --directory build --base-directory . --output-file lcov.info
```

| 옵션 | 설명 |
|---|---|
| `--capture` | .gcda 파일에서 커버리지 데이터 수집 |
| `--directory build` | .gcda 파일을 찾을 폴더 |
| `--base-directory .` | 소스 파일 기준 경로 (프로젝트 루트) |
| `--output-file lcov.info` | 결과 저장 파일명 |

**4. lcov.info 정상 생성 확인**
```cmd
cd 프로젝트루트
type lcov.info | findstr SF:
```

`SF:` 는 커버리지가 측정된 소스 파일 경로를 의미합니다. 정상이면 아래처럼 출력됩니다:
```
SF:C:/DEV/프로젝트루트/src/Xxx.cpp
SF:C:/DEV/프로젝트루트/tests/XxxTest.cpp
```

아무것도 출력되지 않으면 lcov.info 가 비어있거나 경로 문제가 있는 것입니다.

**5. VSCode Coverage Gutters 표시**

```
Ctrl+Shift+P → Coverage Gutters: Display Coverage
```

반드시 `src/Xxx.cpp` 실제 구현 파일을 열고 실행합니다. 테스트 파일이 아니라 구현 파일을 열어야 변화가 보입니다.

| 표시 | 의미 |
|---|---|
| 초록색 줄 | 테스트가 실행한 코드 |
| 빨간색 줄 | 테스트가 실행하지 않은 코드 |
| 하단 `File XX% Covered` | 현재 파일의 커버리지 비율 |

### 커버리지 재수집 (테스트 추가 후)

```cmd
cd 프로젝트루트
cmake --build build
cd build
ctest --output-on-failure
cd ..
lcov --capture --directory build --base-directory . --output-file lcov.info
```

`Ctrl+Shift+P` → `Coverage Gutters: Display Coverage` 재실행 후 커버리지 상승을 확인합니다.

### 전체 흐름 요약

```
ctest --output-on-failure           <- 테스트 실행 + .gcda 생성
        |
        v
dir /s *.gcda                       <- .gcda 생성 확인
        |
        v
lcov --capture --directory build    <- .gcda → lcov.info 변환
     --base-directory .
     --output-file lcov.info
        |
        v
type lcov.info | findstr SF:        <- lcov.info 정상 생성 확인
        |
        v
Coverage Gutters: Display Coverage  <- VSCode 커버리지 시각화
        |
        v
src/Xxx.cpp 열기 → 초록/빨간 줄 확인
```


