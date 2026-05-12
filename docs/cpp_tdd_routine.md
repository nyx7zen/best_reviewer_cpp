# C++ TDD 루틴 정리

## 1. TDD 3단계 사이클

| 단계 | 색상 | 내용 |
|---|---|---|
| 1단계 | RED | 실패하는 테스트를 먼저 작성 |
| 2단계 | GREEN | 테스트를 가까스로 통과시킬 최소 코드 구현 |
| 3단계 | REFACTOR | 동작을 유지하면서 코드를 간결하게 정리 |

---

## 2. TDD 사이클 흐름

```
tests/XxxTest.cpp 에 테스트 작성 (RED)
        |
        v
cmake --build build
        |
        v
ctest --output-on-failure
        |
        v
      FAIL 확인  <-- RED 단계 완료
        |
        v
src/Xxx.cpp 수정 (GREEN)
        |
        v
cmake --build build
        |
        v
ctest --output-on-failure
        |
        v
      PASS 확인  <-- GREEN 단계 완료
        |
        v
코드 정리 (REFACTOR)
        |
        v
cmake --build build
        |
        v
ctest --output-on-failure
        |
        v
      PASS 유지 확인  <-- REFACTOR 단계 완료
        |
        v
git add . && git commit -m "feat: 기능 설명"
        |
        v
     다음 테스트로 반복
```

---

## 3. 매 사이클 반복 명령어

### 빌드 (루트에서)
```cmd
cd 프로젝트루트
cmake --build build
```

### 테스트 (build 폴더에서)
```cmd
cd 프로젝트루트\build
ctest --output-on-failure
```

### 테스트 상세 결과 (build 폴더에서)
```cmd
cd 프로젝트루트\build
XxxTest.exe --gtest_print_time=1
```

### 특정 테스트만 실행
```cmd
XxxTest.exe --gtest_filter=테스트스위트명.테스트명
```

### 전체 테스트 목록 확인
```cmd
XxxTest.exe --gtest_list_tests
```

---

## 4. GoogleTest 주요 매크로

### EXPECT 계열 — 실패해도 계속 진행

| 매크로 | 설명 |
|---|---|
| `EXPECT_EQ(expected, actual)` | expected == actual |
| `EXPECT_NE(a, b)` | a != b |
| `EXPECT_LT(a, b)` | a < b |
| `EXPECT_GT(a, b)` | a > b |
| `EXPECT_TRUE(cond)` | cond == true |
| `EXPECT_FALSE(cond)` | cond == false |
| `EXPECT_FLOAT_EQ(a, b)` | 부동소수점 근사 비교 |
| `EXPECT_THROW(expr, exception)` | 예외 발생 확인 |
| `EXPECT_NO_THROW(expr)` | 예외 없음 확인 |

### ASSERT 계열 — 실패 시 즉시 중단

| 매크로 | 설명 |
|---|---|
| `ASSERT_EQ(expected, actual)` | expected == actual |
| `ASSERT_TRUE(cond)` | cond == true |
| `ASSERT_THROW(expr, exception)` | 예외 발생 확인 |

---

## 5. 테스트 코드 기본 구조

### AAA 패턴 (Arrange - Act - Assert)

```cpp
#include "gtest/gtest.h"
#include "../include/Xxx.h"

TEST(테스트스위트명, 테스트명) {
    // Arrange: 객체 생성 및 초기값 설정
    Xxx obj;

    // Act: 테스트 대상 메서드 실행
    int result = obj.someMethod(4, 2);

    // Assert: 결과 검증
    EXPECT_EQ(6, result);
}
```

### TEST_F — Fixture 공유

```cpp
class XxxTest : public ::testing::Test {
protected:
    Xxx obj;

    void SetUp() override {
        // 각 테스트 실행 전 초기화
    }

    void TearDown() override {
        // 각 테스트 실행 후 정리
    }
};

TEST_F(XxxTest, 테스트명) {
    EXPECT_EQ(6, obj.someMethod(4, 2));
}
```

---

## 6. 테스트 케이스 작성 기준 (Right-BICEP)

| 항목 | 내용 | 예시 |
|---|---|---|
| Right | 정상 동작 확인 | `addition(4, 2) == 6` |
| Boundary | 경계값 테스트 | `addition(0, 0)`, `INT_MAX` |
| Inverse | 역관계 테스트 | `add(5,5)=10` → `subtract(10,5)=5` |
| Cross-check | 교차 검증 | `add(2,3) == add(3,2)` |
| Error | 예외 처리 테스트 | `division(4, 0)` → 예외 발생 |
| Performance | 성능 테스트 | 1ms 이내 처리 확인 |

---

## 7. 테스트 케이스 예시 — Arithmetic 사칙연산

```cpp
#include "gtest/gtest.h"
#include "../include/ArithmeticOperations.h"

TEST(ArithmeticTest, Addition_Positive) {
    ArithmeticOperations ao;
    EXPECT_EQ(6, ao.addition(4, 2));
}

TEST(ArithmeticTest, Addition_Negative) {
    ArithmeticOperations ao;
    EXPECT_EQ(-11, ao.addition(-1, -10));
}

TEST(ArithmeticTest, Division_ByZero_Throws) {
    ArithmeticOperations ao;
    EXPECT_THROW(ao.division(4, 0), std::invalid_argument);
}

TEST(ArithmeticTest, Quotient_Basic) {
    ArithmeticOperations ao;
    EXPECT_FLOAT_EQ(2.5f, ao.quotient(5, 2));
}
```

---

## 8. 단계별 커밋 메시지 규칙

| 단계 | 메시지 형식 | 예시 |
|---|---|---|
| 초기 프로젝트 생성 | `feat: 초기 프로젝트 구성` | |
| RED 단계 | `test: XxxTest RED 단계 추가` | `test: ArithmeticTest RED 단계 추가` |
| GREEN 단계 | `feat: Xxx 기능 구현` | `feat: quotient 구현` |
| REFACTOR 단계 | `refactor: Xxx 코드 정리` | `refactor: division 예외처리 개선` |
| 버그 수정 | `fix: Xxx 버그 수정` | `fix: largest 초기값 오류 수정` |

---

## 9. TDD 완료 후 GitHub Push

```cmd
cd 프로젝트루트
git add .
git commit -m "feat: 커밋 메시지"
git push
```

---

## 10. 자주 발생하는 오류 및 해결

| 오류 | 원인 | 해결 |
|---|---|---|
| `gcc.exe` 링크 오류 | C++ 파일을 gcc 로 컴파일 | tasks.json 에서 `gcc.exe` → `g++.exe` 변경 |
| `CMakeLists.txt not found` (FetchContent) | FetchContent URL 오타 | URL 확인 후 `rmdir /s /q build` 후 재빌드 |
| `CMakeLists.txt not found` (external) | googletest 폴더 중첩 | `dir external\googletest-1.16.0` 으로 확인 후 폴더 중첩 제거 |
| `Cannot find source file` | 파일 경로 오타 | CMakeLists.txt 의 경로 확인 (`test` vs `tests`) |
| `remote origin already exists` | remote 중복 등록 | `git remote remove origin` 후 재등록 |
| 빌드 후에도 변경 미반영 | build 폴더 캐시 | `rmdir /s /q build` 후 재빌드 |
| `lcov: command not found` | lcov.bat 미생성 또는 PATH 미등록 | lcov.bat 생성 확인 및 PATH 등록 확인 |

---

## 11. 테스트 커버리지 확인 절차

### 전제 조건

**CMakeLists.txt 에 `--coverage` 옵션 추가 여부 확인:**

```cmake
target_compile_options(XxxTest PRIVATE --coverage)
target_link_options(XxxTest PRIVATE --coverage)
```

**`.vscode/settings.json` 생성 여부 확인:**

```cmd
cd 프로젝트루트
mkdir .vscode
```

`.vscode/settings.json` 파일을 생성하고 아래 내용을 작성합니다:

```json
{
  "coverage-gutters.lcovname": "build/lcov.info"
}
```

옵션 추가 또는 settings.json 신규 생성 시 반드시 재Configure 후 재빌드합니다:

```cmd
cd 프로젝트루트
rmdir /s /q build
cmake -S . -B build -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=C:\mingw64\bin\g++.exe
cmake --build build
```

---

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

---

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

---

### 전체 흐름 요약

```
.vscode/settings.json 생성          <- coverage-gutters lcov.info 경로 설정
        |
        v
CMakeLists.txt --coverage 옵션 추가
        |
        v
rmdir /s /q build (재Configure 필요)
cmake -S . -B build -G "MinGW Makefiles"
cmake --build build
        |
        v
cd build
ctest --output-on-failure           <- 테스트 실행 + .gcda 생성
        |
        v
dir /s *.gcda                       <- .gcda 생성 확인
        |
        v
cd ..
lcov --capture --directory build    <- .gcda → lcov.info 변환
     --base-directory .
     --output-file lcov.info
        |
        v
type lcov.info | findstr SF:        <- lcov.info 정상 생성 확인
        |
        v
Ctrl+Shift+P
Coverage Gutters: Display Coverage  <- VSCode 커버리지 시각화
        |
        v
src/Xxx.cpp 열기 → 초록/빨간 줄 확인
        |
        v
빨간 줄 확인 → 테스트 추가 → 커버리지 재수집 반복
```

### 커버리지를 높이는 방법

빨간색으로 표시된 코드가 있으면 해당 코드를 실행하는 테스트를 추가합니다.

예시 — `quotient` 미테스트 상태:
```
quotient() 메서드 → 빨간색  <- 테스트 없음
```

`tests/XxxTest.cpp` 에 테스트 추가:
```cpp
TEST(ArithmeticTest, Quotient_Basic) {
    ArithmeticOperations ao;
    EXPECT_FLOAT_EQ(2.5f, ao.quotient(5, 2));
}
```

테스트 추가 후 커버리지 재수집:
```cmd
cd 프로젝트루트
cmake --build build
cd build
ctest --output-on-failure
cd ..
lcov --capture --directory build --base-directory . --output-file lcov.info
```

`Ctrl+Shift+P` → `Coverage Gutters: Display Coverage` 재실행 후 커버리지 상승 확인합니다.
