# CMakeLists.txt — Google vs Microsoft 스타일 비교 및 템플릿

---

## 1. CMakeLists.txt 와 네이밍 스타일의 관계

CMakeLists.txt 는 빌드 스크립트이므로 Google / Microsoft 네이밍 스타일 자체의 영향은 크지 않습니다.
두 스타일의 차이는 주로 아래 세 가지에서 나타납니다.

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 프로젝트명 | `snake_case` | `PascalCase` |
| 실행파일명 / 라이브러리명 | `snake_case` | `PascalCase` |
| 소스 파일 경로 | `src/plus.cc` | `src/Plus.cpp` |
| 테스트 파일 경로 | `tests/plus_test.cc` | `tests/TestPlus.cpp` |
| 외부 라이브러리 경로 | `third_party/googletest-1.16.0` | `external/googletest-1.16.0` |
| 빌드 방식 | Modern CMake 권장 | Modern CMake 권장 |

CMake 작성 원칙 자체(Modern CMake 방식)는 두 스타일 모두 동일합니다.

---

## 2. Modern CMake 핵심 원칙

| 원칙 | 구식 방식 (Legacy) | 권장 방식 (Modern) |
|---|---|---|
| 헤더 경로 지정 | `include_directories(include)` (전역) | `target_include_directories(타겟 PRIVATE include)` (타겟 한정) |
| 소스 라이브러리 | 소스 파일을 각 타겟에 중복 나열 | `add_library` 로 한 번만 컴파일 |
| 링크 | `target_link_libraries(타겟 라이브러리)` | `target_link_libraries(타겟 PRIVATE/PUBLIC 라이브러리)` |
| GoogleTest 포함 | `add_subdirectory` (로컬 폴더) | `FetchContent` (자동 다운로드) |
| CMake 최소 버전 | 3.10 이하 | FetchContent: 3.14 / add_subdirectory: 3.10 |

---

## 3. 폴더 구조 — Google vs Microsoft

### Google Style

```
arithmetic_operations/
  include/
    plus.h
    minus.h
    arithmetic_operations.h
  src/
    plus.cc
    minus.cc
    arithmetic_operations.cc
    main.cc
  tests/
    plus_test.cc
    minus_test.cc
    arithmetic_operations_test.cc
  third_party/                    <- 인터넷 불가 환경
    googletest-1.16.0/
  build/
  CMakeLists.txt
  .gitignore
  README.md
```

### Microsoft Style

```
ArithmeticOperations/
  include/
    Plus.h
    Minus.h
    ArithmeticOperations.h
  src/
    Plus.cpp
    Minus.cpp
    ArithmeticOperations.cpp
    main.cpp
  tests/
    TestPlus.cpp
    TestMinus.cpp
    TestArithmeticOperations.cpp
  external/                       <- 인터넷 불가 환경
    googletest-1.16.0/
  build/
  CMakeLists.txt
  .gitignore
  README.md
```

---

## 4. CMakeLists.txt — Google Style (FetchContent 방식)

인터넷 연결 가능한 환경에서 사용합니다.

```cmake
cmake_minimum_required(VERSION 3.14)

project(arithmetic_operations
    VERSION 0.1.0
    LANGUAGES CXX
    DESCRIPTION "Arithmetic Operations TDD Example"
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -------------------------------------------------------
# 소스 라이브러리
# -------------------------------------------------------
set(SRC_LIB arithmetic_lib)

add_library(${SRC_LIB} STATIC
    src/plus.cc
    src/minus.cc
    src/arithmetic_operations.cc
)

target_include_directories(${SRC_LIB}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# -------------------------------------------------------
# 메인 실행파일
# -------------------------------------------------------
add_executable(arithmetic_operations
    src/main.cc
)

target_link_libraries(arithmetic_operations
    PRIVATE
        ${SRC_LIB}
)

# -------------------------------------------------------
# GoogleTest — FetchContent 방식 (자동 다운로드)
# -------------------------------------------------------
include(FetchContent)

FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.16.0.zip
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
    TLS_VERIFY OFF
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# -------------------------------------------------------
# 테스트 실행파일
# -------------------------------------------------------
enable_testing()

add_executable(plus_test
    tests/plus_test.cc
)
target_link_libraries(plus_test
    PRIVATE
        GTest::gtest_main
        ${SRC_LIB}
)
target_compile_options(plus_test PRIVATE --coverage)
target_link_options(plus_test PRIVATE --coverage)
add_test(NAME plus_test COMMAND plus_test)

add_executable(minus_test
    tests/minus_test.cc
)
target_link_libraries(minus_test
    PRIVATE
        GTest::gtest_main
        ${SRC_LIB}
)
target_compile_options(minus_test PRIVATE --coverage)
target_link_options(minus_test PRIVATE --coverage)
add_test(NAME minus_test COMMAND minus_test)

add_executable(arithmetic_operations_test
    tests/arithmetic_operations_test.cc
)
target_link_libraries(arithmetic_operations_test
    PRIVATE
        GTest::gtest_main
        ${SRC_LIB}
)
target_compile_options(arithmetic_operations_test PRIVATE --coverage)
target_link_options(arithmetic_operations_test PRIVATE --coverage)
add_test(NAME arithmetic_operations_test COMMAND arithmetic_operations_test)
```

---

## 5. CMakeLists.txt — Google Style (external/add_subdirectory 방식)

인터넷 연결 불가한 환경에서 사용합니다.

```cmake
cmake_minimum_required(VERSION 3.10...3.28)

project(arithmetic_operations
    VERSION 0.1.0
    LANGUAGES CXX
    DESCRIPTION "Arithmetic Operations TDD Example"
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -------------------------------------------------------
# 소스 라이브러리
# -------------------------------------------------------
set(SRC_LIB arithmetic_lib)

add_library(${SRC_LIB} STATIC
    src/plus.cc
    src/minus.cc
    src/arithmetic_operations.cc
)

target_include_directories(${SRC_LIB}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# -------------------------------------------------------
# 메인 실행파일
# -------------------------------------------------------
add_executable(arithmetic_operations
    src/main.cc
)

target_link_libraries(arithmetic_operations
    PRIVATE
        ${SRC_LIB}
)

# -------------------------------------------------------
# GoogleTest — external/add_subdirectory 방식 (로컬 폴더)
# -------------------------------------------------------
add_subdirectory(third_party/googletest-1.16.0)

# -------------------------------------------------------
# 테스트 실행파일
# -------------------------------------------------------
enable_testing()

add_executable(plus_test
    tests/plus_test.cc
)
target_link_libraries(plus_test
    PRIVATE
        gtest_main
        ${SRC_LIB}
)
target_compile_options(plus_test PRIVATE --coverage)
target_link_options(plus_test PRIVATE --coverage)
add_test(NAME plus_test COMMAND plus_test)

add_executable(minus_test
    tests/minus_test.cc
)
target_link_libraries(minus_test
    PRIVATE
        gtest_main
        ${SRC_LIB}
)
target_compile_options(minus_test PRIVATE --coverage)
target_link_options(minus_test PRIVATE --coverage)
add_test(NAME minus_test COMMAND minus_test)

add_executable(arithmetic_operations_test
    tests/arithmetic_operations_test.cc
)
target_link_libraries(arithmetic_operations_test
    PRIVATE
        gtest_main
        ${SRC_LIB}
)
target_compile_options(arithmetic_operations_test PRIVATE --coverage)
target_link_options(arithmetic_operations_test PRIVATE --coverage)
add_test(NAME arithmetic_operations_test COMMAND arithmetic_operations_test)
```

---

## 6. CMakeLists.txt — Microsoft Style (FetchContent 방식)

```cmake
cmake_minimum_required(VERSION 3.14)

project(ArithmeticOperations
    VERSION 0.1.0
    LANGUAGES CXX
    DESCRIPTION "Arithmetic Operations TDD Example"
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -------------------------------------------------------
# 소스 라이브러리
# -------------------------------------------------------
set(SRC_LIB ArithmeticLib)

add_library(${SRC_LIB} STATIC
    src/Plus.cpp
    src/Minus.cpp
    src/ArithmeticOperations.cpp
)

target_include_directories(${SRC_LIB}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# -------------------------------------------------------
# 메인 실행파일
# -------------------------------------------------------
add_executable(ArithmeticOperations
    src/main.cpp
)

target_link_libraries(ArithmeticOperations
    PRIVATE
        ${SRC_LIB}
)

# -------------------------------------------------------
# GoogleTest — FetchContent 방식 (자동 다운로드)
# -------------------------------------------------------
include(FetchContent)

FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.16.0.zip
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
    TLS_VERIFY OFF
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# -------------------------------------------------------
# 테스트 실행파일
# -------------------------------------------------------
enable_testing()

add_executable(TestPlus
    tests/TestPlus.cpp
)
target_link_libraries(TestPlus
    PRIVATE
        GTest::gtest_main
        ${SRC_LIB}
)
target_compile_options(TestPlus PRIVATE --coverage)
target_link_options(TestPlus PRIVATE --coverage)
add_test(NAME TestPlus COMMAND TestPlus)

add_executable(TestMinus
    tests/TestMinus.cpp
)
target_link_libraries(TestMinus
    PRIVATE
        GTest::gtest_main
        ${SRC_LIB}
)
target_compile_options(TestMinus PRIVATE --coverage)
target_link_options(TestMinus PRIVATE --coverage)
add_test(NAME TestMinus COMMAND TestMinus)

add_executable(TestArithmeticOperations
    tests/TestArithmeticOperations.cpp
)
target_link_libraries(TestArithmeticOperations
    PRIVATE
        GTest::gtest_main
        ${SRC_LIB}
)
target_compile_options(TestArithmeticOperations PRIVATE --coverage)
target_link_options(TestArithmeticOperations PRIVATE --coverage)
add_test(NAME TestArithmeticOperations COMMAND TestArithmeticOperations)
```

---

## 7. CMakeLists.txt — Microsoft Style (external/add_subdirectory 방식)

```cmake
cmake_minimum_required(VERSION 3.10...3.28)

project(ArithmeticOperations
    VERSION 0.1.0
    LANGUAGES CXX
    DESCRIPTION "Arithmetic Operations TDD Example"
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -------------------------------------------------------
# 소스 라이브러리
# -------------------------------------------------------
set(SRC_LIB ArithmeticLib)

add_library(${SRC_LIB} STATIC
    src/Plus.cpp
    src/Minus.cpp
    src/ArithmeticOperations.cpp
)

target_include_directories(${SRC_LIB}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# -------------------------------------------------------
# 메인 실행파일
# -------------------------------------------------------
add_executable(ArithmeticOperations
    src/main.cpp
)

target_link_libraries(ArithmeticOperations
    PRIVATE
        ${SRC_LIB}
)

# -------------------------------------------------------
# GoogleTest — external/add_subdirectory 방식 (로컬 폴더)
# -------------------------------------------------------
add_subdirectory(external/googletest-1.16.0)

# -------------------------------------------------------
# 테스트 실행파일
# -------------------------------------------------------
enable_testing()

add_executable(TestPlus
    tests/TestPlus.cpp
)
target_link_libraries(TestPlus
    PRIVATE
        gtest_main
        ${SRC_LIB}
)
target_compile_options(TestPlus PRIVATE --coverage)
target_link_options(TestPlus PRIVATE --coverage)
add_test(NAME TestPlus COMMAND TestPlus)

add_executable(TestMinus
    tests/TestMinus.cpp
)
target_link_libraries(TestMinus
    PRIVATE
        gtest_main
        ${SRC_LIB}
)
target_compile_options(TestMinus PRIVATE --coverage)
target_link_options(TestMinus PRIVATE --coverage)
add_test(NAME TestMinus COMMAND TestMinus)

add_executable(TestArithmeticOperations
    tests/TestArithmeticOperations.cpp
)
target_link_libraries(TestArithmeticOperations
    PRIVATE
        gtest_main
        ${SRC_LIB}
)
target_compile_options(TestArithmeticOperations PRIVATE --coverage)
target_link_options(TestArithmeticOperations PRIVATE --coverage)
add_test(NAME TestArithmeticOperations COMMAND TestArithmeticOperations)
```

---

## 8. 4가지 CMakeLists.txt 핵심 차이 비교

| 항목 | Google FetchContent | Google external | Microsoft FetchContent | Microsoft external |
|---|---|---|---|---|
| CMake 최소 버전 | `3.14` | `3.10...3.28` | `3.14` | `3.10...3.28` |
| 프로젝트명 | `arithmetic_operations` | `arithmetic_operations` | `ArithmeticOperations` | `ArithmeticOperations` |
| 소스 라이브러리명 | `arithmetic_lib` | `arithmetic_lib` | `ArithmeticLib` | `ArithmeticLib` |
| 메인 실행파일명 | `arithmetic_operations` | `arithmetic_operations` | `ArithmeticOperations` | `ArithmeticOperations` |
| 소스 파일 경로 | `src/plus.cc` | `src/plus.cc` | `src/Plus.cpp` | `src/Plus.cpp` |
| 테스트 파일 경로 | `tests/plus_test.cc` | `tests/plus_test.cc` | `tests/TestPlus.cpp` | `tests/TestPlus.cpp` |
| GoogleTest 방식 | `FetchContent` | `add_subdirectory` | `FetchContent` | `add_subdirectory` |
| GoogleTest 경로 | URL 자동 다운로드 | `third_party/googletest-1.16.0` | URL 자동 다운로드 | `external/googletest-1.16.0` |
| gtest 링크 키워드 | `GTest::gtest_main` | `gtest_main` | `GTest::gtest_main` | `gtest_main` |
| 테스트 실행파일명 | `plus_test` | `plus_test` | `TestPlus` | `TestPlus` |

---

## 9. GTest::gtest_main vs gtest_main 차이

| 항목 | `GTest::gtest_main` | `gtest_main` |
|---|---|---|
| 사용 시점 | FetchContent 방식 | add_subdirectory 방식 |
| CMake 타겟 방식 | Modern CMake (namespace 타겟) | Legacy CMake 타겟 |
| 권장 여부 | 권장 | 사용 가능하지만 구식 |

---

## 10. 공통 템플릿 — 변수 치환 방식

Google / Microsoft 스타일 중 하나를 선택해서 변수만 교체하면 바로 사용할 수 있는 템플릿입니다.

```cmake
cmake_minimum_required(VERSION 3.14)

# -------------------------------------------------------
# [수정] 프로젝트명 — Google: snake_case / MS: PascalCase
# -------------------------------------------------------
project(프로젝트명
    VERSION 0.1.0
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -------------------------------------------------------
# 소스 라이브러리
# [수정] SRC_LIB — Google: snake_case_lib / MS: PascalCaseLib
# [수정] 소스 파일 경로 — Google: src/xxx.cc / MS: src/Xxx.cpp
# -------------------------------------------------------
set(SRC_LIB 소스라이브러리명)

add_library(${SRC_LIB} STATIC
    src/소스파일1
    src/소스파일2
)

target_include_directories(${SRC_LIB}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# -------------------------------------------------------
# 메인 실행파일
# [수정] 실행파일명 — Google: snake_case / MS: PascalCase
# [수정] 소스 파일 경로 — Google: src/main.cc / MS: src/main.cpp
# -------------------------------------------------------
add_executable(실행파일명
    src/main.cpp
)

target_link_libraries(실행파일명
    PRIVATE
        ${SRC_LIB}
)

# -------------------------------------------------------
# GoogleTest
# [선택] 인터넷 가능: FetchContent 방식 (아래 A 사용)
# [선택] 인터넷 불가: add_subdirectory 방식 (아래 B 사용)
# -------------------------------------------------------

# A. FetchContent 방식 (인터넷 가능)
include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.16.0.zip
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
    TLS_VERIFY OFF
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# B. add_subdirectory 방식 (인터넷 불가)
# [수정] Google: third_party / MS: external
# add_subdirectory(third_party/googletest-1.16.0)   # Google Style
# add_subdirectory(external/googletest-1.16.0)      # Microsoft Style

# -------------------------------------------------------
# 테스트 실행파일
# [수정] 테스트 파일명 — Google: xxx_test.cc / MS: TestXxx.cpp
# [수정] gtest 링크 — FetchContent: GTest::gtest_main / add_subdirectory: gtest_main
# -------------------------------------------------------
enable_testing()

add_executable(테스트실행파일명
    tests/테스트파일명
)
target_link_libraries(테스트실행파일명
    PRIVATE
        GTest::gtest_main    # FetchContent 방식
        # gtest_main         # add_subdirectory 방식
        ${SRC_LIB}
)
target_compile_options(테스트실행파일명 PRIVATE --coverage)
target_link_options(테스트실행파일명 PRIVATE --coverage)
add_test(NAME 테스트실행파일명 COMMAND 테스트실행파일명)
```

---

## 11. .gitignore 공통 템플릿

```
/build/
/out/
*.exe
*.o
*.a
*.gcda
*.gcno
lcov.info
.vscode/
```

`*.gcda`, `*.gcno` 는 커버리지 수집 시 생성되는 파일로 커밋에서 제외합니다.
`third_party/` 또는 `external/` 폴더는 인터넷 불가 환경에서는 커밋에 포함해야 합니다.

```
# 인터넷 가능 환경 (FetchContent) — third_party / external 제외
/third_party/
/external/

# 인터넷 불가 환경 (add_subdirectory) — third_party / external 커밋 포함
# /third_party/   <- 주석 처리
# /external/      <- 주석 처리
```
