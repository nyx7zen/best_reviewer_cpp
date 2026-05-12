# C++ 네이밍 Convention — Google vs Microsoft 비교

---

## 1. 기본 원칙

| 원칙 | 내용 |
|---|---|
| 일관성 | 프로젝트 내에서 한 가지 스타일을 선택하고 끝까지 유지 |
| 명확성 | 이름만 보고 역할을 즉시 파악할 수 있어야 함 |
| 축약 금지 | `calc` 보다 `calculator`, `ao` 보다 `arithmetic_operations` 권장 |
| 팀 합의 | 개인 선호보다 팀 기준이 우선 |

---

## 2. 폴더명

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 일반 폴더명 | `snake_case` | `snake_case` 또는 `PascalCase` |
| 소스 폴더 | `src` | `src` |
| 헤더 폴더 | `include` | `include` |
| 테스트 폴더 | `tests` | `tests` |
| 외부 라이브러리 폴더 | `third_party` | `external` 또는 `third_party` |
| 빌드 폴더 | `build` | `build` |
| 문서 폴더 | `docs` | `docs` |

폴더명은 두 스타일 모두 `snake_case` 또는 `lowercase` 를 사용하는 것이 일반적입니다. 폴더명에 PascalCase 를 사용하는 경우는 드뭅니다.

### 루트명 (레포명) 비교

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 레포명 패턴 | `snake_case` | `PascalCase` 또는 `kebab-case` |
| 프로젝트 폴더명 | `arithmetic_operations` | `ArithmeticOperations` |

### 사칙연산 예제 — 루트명

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 레포명 | `arithmetic_operations` | `ArithmeticOperations` |
| GitHub URL | `github.com/user/arithmetic_operations` | `github.com/user/ArithmeticOperations` |

---

## 3. 프로젝트 폴더 구조

폴더 구조 자체는 두 스타일 간에 큰 차이가 없습니다. 다만 폴더명과 파일명 표기 방식에서 차이가 납니다.

### Google Style — arithmetic_operations

```
arithmetic_operations/          <- 루트 (레포명) — snake_case
  include/                      <- 헤더 파일
    plus.h
    minus.h
    arithmetic_operations.h
  src/                          <- 소스 파일
    plus.cc
    minus.cc
    arithmetic_operations.cc
    main.cc
  tests/                        <- 테스트 파일
    plus_test.cc
    minus_test.cc
    arithmetic_operations_test.cc
  third_party/                  <- 외부 라이브러리 (인터넷 불가 환경)
    googletest-1.16.0/
  docs/                         <- 문서
  build/                        <- 빌드 산출물 (gitignore)
  CMakeLists.txt
  .gitignore
  README.md
```

### Microsoft Style — ArithmeticOperations

```
ArithmeticOperations/           <- 루트 (레포명) — PascalCase
  include/                      <- 헤더 파일
    Plus.h
    Minus.h
    ArithmeticOperations.h
  src/                          <- 소스 파일
    Plus.cpp
    Minus.cpp
    ArithmeticOperations.cpp
    main.cpp
  tests/                        <- 테스트 파일
    TestPlus.cpp
    TestMinus.cpp
    TestArithmeticOperations.cpp
  external/                     <- 외부 라이브러리 (인터넷 불가 환경)
    googletest-1.16.0/
  docs/                         <- 문서
  build/                        <- 빌드 산출물 (gitignore)
  CMakeLists.txt
  .gitignore
  README.md
```

### 두 스타일 폴더 구조 비교

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 루트 폴더명 | `arithmetic_operations` | `ArithmeticOperations` |
| 헤더 폴더 | `include/` | `include/` |
| 소스 폴더 | `src/` | `src/` |
| 테스트 폴더 | `tests/` | `tests/` |
| 외부 라이브러리 폴더 | `third_party/` | `external/` |
| 빌드 폴더 | `build/` | `build/` |
| 헤더 파일명 | `plus.h` | `Plus.h` |
| 소스 파일명 | `plus.cc` | `Plus.cpp` |
| 테스트 파일명 | `plus_test.cc` | `TestPlus.cpp` |
| 소스 확장자 | `.cc` | `.cpp` |

---

## 4. 파일명

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 헤더 파일 | `snake_case.h` | `PascalCase.h` |
| 소스 파일 | `snake_case.cc` | `PascalCase.cpp` |
| 테스트 파일 | `snake_case_test.cc` | `TestPascalCase.cpp` |

### 사칙연산 예제

| 파일 역할 | Google Style | Microsoft Style |
|---|---|---|
| Plus 헤더 | `plus.h` | `Plus.h` |
| Plus 소스 | `plus.cc` | `Plus.cpp` |
| Minus 헤더 | `minus.h` | `Minus.h` |
| Minus 소스 | `minus.cc` | `Minus.cpp` |
| ArithmeticOperations 헤더 | `arithmetic_operations.h` | `ArithmeticOperations.h` |
| ArithmeticOperations 소스 | `arithmetic_operations.cc` | `ArithmeticOperations.cpp` |
| Plus 테스트 | `plus_test.cc` | `TestPlus.cpp` |
| Minus 테스트 | `minus_test.cc` | `TestMinus.cpp` |
| ArithmeticOperations 테스트 | `arithmetic_operations_test.cc` | `TestArithmeticOperations.cpp` |

---

## 5. 변수명

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 지역 변수 | `snake_case` | `camelCase` |
| 멤버 변수 | `snake_case_` (접미사 `_`) | `m_camelCase` (접두사 `m_`) |
| 정적 멤버 변수 | `s_snake_case_` | `s_camelCase` |
| 전역 변수 | `g_snake_case` | `g_camelCase` |
| 상수 | `kPascalCase` | `ALL_CAPS` 또는 `PascalCase` |
| 포인터 변수 | `snake_case_ptr` | `m_pCamelCase` |

### 사칙연산 예제

```cpp
// Google Style
int first_number = 4;           // 지역 변수 — snake_case
int second_number = 2;
int last_result_ = 0;           // 멤버 변수 — snake_case + _ 접미사
static int s_call_count_ = 0;   // 정적 멤버 변수
const int kMaxValue = 1000;     // 상수 — k + PascalCase

// Microsoft Style
int firstNumber = 4;            // 지역 변수 — camelCase
int secondNumber = 2;
int m_lastResult = 0;           // 멤버 변수 — m_ + camelCase
static int s_callCount = 0;     // 정적 멤버 변수
const int MAX_VALUE = 1000;     // 상수 — ALL_CAPS
```

---

## 6. 함수명 (전역 함수)

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 전역 함수 | `PascalCase` | `PascalCase` |
| 헬퍼 함수 | `PascalCase` | `PascalCase` |

두 스타일 모두 전역 함수는 PascalCase 로 동일합니다.

```cpp
// Google Style / Microsoft Style 동일
int CalculateSum(int x, int y);
bool IsValidInput(int value);
void PrintResult(int result);
```

---

## 7. 클래스명

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 클래스명 | `PascalCase` | `PascalCase` |
| 구조체명 | `PascalCase` | `PascalCase` |
| 인터페이스 | `PascalCase` | `IPascalCase` (I 접두사) |
| 추상 클래스 | `PascalCase` | `PascalCase` 또는 `AbstractXxx` |

두 스타일 모두 클래스명은 PascalCase 로 동일합니다.

### 사칙연산 예제

```cpp
// Google Style / Microsoft Style 동일
class Plus { };
class Minus { };
class ArithmeticOperations { };
class PrimeChecker { };
```

---

## 8. 클래스 메서드명

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 일반 메서드 | `PascalCase` | `PascalCase` |
| getter | `snake_case()` (소문자) | `GetXxx()` (Get 접두사) |
| setter | `set_xxx()` (set_ 접두사) | `SetXxx()` (Set 접두사) |
| bool 반환 | `IsXxx()`, `HasXxx()` | `IsXxx()`, `HasXxx()` |

### 사칙연산 예제

```cpp
// Google Style
class ArithmeticOperations {
public:
    // 일반 메서드 — PascalCase
    int Addition(int x, int y);
    int Subtraction(int x, int y);
    int Multiplication(int x, int y);
    int Division(int x, int y);
    float Quotient(int x, int y);

    // getter — snake_case (소문자)
    int last_result() const { return last_result_; }
    std::string operator_type() const { return operator_type_; }

    // setter — set_ + snake_case
    void set_last_result(int result) { last_result_ = result; }
    void set_operator_type(const std::string& type) { operator_type_ = type; }

private:
    int last_result_ = 0;              // 멤버 변수 — snake_case + _ 접미사
    std::string operator_type_;
};

// Microsoft Style
class ArithmeticOperations {
public:
    // 일반 메서드 — PascalCase
    int Addition(int x, int y);
    int Subtraction(int x, int y);
    int Multiplication(int x, int y);
    int Division(int x, int y);
    float Quotient(int x, int y);

    // getter — Get + PascalCase
    int GetLastResult() const { return m_lastResult; }
    std::string GetOperatorType() const { return m_operatorType; }

    // setter — Set + PascalCase
    void SetLastResult(int result) { m_lastResult = result; }
    void SetOperatorType(const std::string& type) { m_operatorType = type; }

private:
    int m_lastResult = 0;              // 멤버 변수 — m_ + camelCase
    std::string m_operatorType;
};
```

---

## 9. 헤더 가드

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 헤더 가드 패턴 | `FILENAME_H_` (언더스코어 포함) | `FILENAME_H` |
| `#pragma once` | 사용 가능 (권장하지 않음) | 사용 가능 (권장) |

### 사칙연산 예제

```cpp
// Google Style
#ifndef PLUS_H_
#define PLUS_H_
// ...
#endif  // PLUS_H_

// Microsoft Style
#ifndef PLUS_H
#define PLUS_H
// ...
#endif  // PLUS_H

// 또는 Microsoft Style — #pragma once 권장
#pragma once
```

---

## 10. 네임스페이스

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 네임스페이스명 | `snake_case` | `PascalCase` |

```cpp
// Google Style
namespace arithmetic_operations {
    class Plus { };
}

// Microsoft Style
namespace ArithmeticOperations {
    class Plus { };
}
```

---

## 11. 테스트 파일명 및 테스트 스위트명

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| 테스트 파일명 | `plus_test.cc` | `TestPlus.cpp` |
| 테스트 스위트명 패턴 | `클래스명 + Test` | `Test + 클래스명` |
| Fixture 클래스명 패턴 | `클래스명 + Test` | `Test + 클래스명` |

### 사칙연산 예제

```cpp
// Google Style — plus_test.cc
TEST(PlusTest, ...)
TEST(MinusTest, ...)
TEST(ArithmeticOperationsTest, ...)

// Microsoft Style — TestPlus.cpp
TEST(TestPlus, ...)
TEST(TestMinus, ...)
TEST(TestArithmeticOperations, ...)
```

---

## 12. 테스트 케이스명

두 스타일 모두 테스트 케이스명은 동일한 패턴을 사용합니다.

| 패턴 | 예시 | 설명 |
|---|---|---|
| `메서드명_Basic` | `Addition_Basic` | 기본 정상 동작 |
| `메서드명_Negative` | `Addition_Negative` | 음수 입력 |
| `메서드명_Zero` | `Addition_Zero` | 0 입력 |
| `메서드명_Boundary` | `Division_Boundary` | 경계값 |
| `메서드명_ThrowsWhen조건` | `Division_ThrowsWhenZero` | 예외 발생 |
| `메서드명_ReturnsXxx` | `Quotient_ReturnsFloat` | 반환값 명시 |

### 사칙연산 예제

```cpp
// Google Style / Microsoft Style 동일
TEST(PlusTest or TestPlus, Addition_Basic)
TEST(PlusTest or TestPlus, Addition_Negative)
TEST(PlusTest or TestPlus, Addition_Zero)

TEST(ArithmeticOperationsTest or TestArithmeticOperations, Division_Basic)
TEST(ArithmeticOperationsTest or TestArithmeticOperations, Division_ThrowsWhenZero)
TEST(ArithmeticOperationsTest or TestArithmeticOperations, Quotient_ReturnsFloat)
```

---

## 13. TEST / TEST_F 전체 코드 비교

### Google Style — arithmetic_operations_test.cc

```cpp
#include "gtest/gtest.h"
#include "arithmetic_operations.h"

// TEST 방식 — 간단한 테스트
TEST(ArithmeticOperationsTest, Addition_Basic) {
    ArithmeticOperations ao;
    EXPECT_EQ(6, ao.Addition(4, 2));
}

TEST(ArithmeticOperationsTest, Addition_Negative) {
    ArithmeticOperations ao;
    EXPECT_EQ(-11, ao.Addition(-1, -10));
}

TEST(ArithmeticOperationsTest, Division_ThrowsWhenZero) {
    ArithmeticOperations ao;
    EXPECT_THROW(ao.Division(4, 0), std::invalid_argument);
}

TEST(ArithmeticOperationsTest, Quotient_ReturnsFloat) {
    ArithmeticOperations ao;
    EXPECT_FLOAT_EQ(2.5f, ao.Quotient(5, 2));
}

// TEST_F 방식 — Fixture 공유
class ArithmeticOperationsTest : public ::testing::Test {
protected:
    ArithmeticOperations ao_;       // 멤버 변수 — snake_case + _ 접미사

    void SetUp() override { }
    void TearDown() override { }
};

TEST_F(ArithmeticOperationsTest, Addition_Basic) {
    EXPECT_EQ(6, ao_.Addition(4, 2));
}

TEST_F(ArithmeticOperationsTest, Division_ThrowsWhenZero) {
    EXPECT_THROW(ao_.Division(4, 0), std::invalid_argument);
}
```

### Microsoft Style — TestArithmeticOperations.cpp

```cpp
#include "gtest/gtest.h"
#include "../src/ArithmeticOperations.h"

// TEST 방식 — 간단한 테스트
TEST(TestArithmeticOperations, Addition_Basic) {
    ArithmeticOperations ao;
    EXPECT_EQ(6, ao.Addition(4, 2));
}

TEST(TestArithmeticOperations, Addition_Negative) {
    ArithmeticOperations ao;
    EXPECT_EQ(-11, ao.Addition(-1, -10));
}

TEST(TestArithmeticOperations, Division_ThrowsWhenZero) {
    ArithmeticOperations ao;
    EXPECT_THROW(ao.Division(4, 0), std::invalid_argument);
}

TEST(TestArithmeticOperations, Quotient_ReturnsFloat) {
    ArithmeticOperations ao;
    EXPECT_FLOAT_EQ(2.5f, ao.Quotient(5, 2));
}

// TEST_F 방식 — Fixture 공유
class TestArithmeticOperations : public ::testing::Test {
protected:
    ArithmeticOperations m_ao;      // 멤버 변수 — m_ + camelCase

    void SetUp() override { }
    void TearDown() override { }
};

TEST_F(TestArithmeticOperations, Addition_Basic) {
    EXPECT_EQ(6, m_ao.Addition(4, 2));
}

TEST_F(TestArithmeticOperations, Division_ThrowsWhenZero) {
    EXPECT_THROW(m_ao.Division(4, 0), std::invalid_argument);
}
```

---

## 14. 테스트 실행 결과 비교

### Google Style 실행 결과
```
[----------] 4 tests from ArithmeticOperationsTest
[ RUN      ] ArithmeticOperationsTest.Addition_Basic
[       OK ] ArithmeticOperationsTest.Addition_Basic
[ RUN      ] ArithmeticOperationsTest.Addition_Negative
[       OK ] ArithmeticOperationsTest.Addition_Negative
[ RUN      ] ArithmeticOperationsTest.Division_ThrowsWhenZero
[       OK ] ArithmeticOperationsTest.Division_ThrowsWhenZero
[ RUN      ] ArithmeticOperationsTest.Quotient_ReturnsFloat
[       OK ] ArithmeticOperationsTest.Quotient_ReturnsFloat
[  PASSED  ] 4 tests.
```

### Microsoft Style 실행 결과
```
[----------] 4 tests from TestArithmeticOperations
[ RUN      ] TestArithmeticOperations.Addition_Basic
[       OK ] TestArithmeticOperations.Addition_Basic
[ RUN      ] TestArithmeticOperations.Addition_Negative
[       OK ] TestArithmeticOperations.Addition_Negative
[ RUN      ] TestArithmeticOperations.Division_ThrowsWhenZero
[       OK ] TestArithmeticOperations.Division_ThrowsWhenZero
[ RUN      ] TestArithmeticOperations.Quotient_ReturnsFloat
[       OK ] TestArithmeticOperations.Quotient_ReturnsFloat
[  PASSED  ] 4 tests.
```

---

## 15. 특정 테스트 실행 — gtest_filter 활용

```cmd
// Google Style
ArithmeticTest.exe --gtest_filter=ArithmeticOperationsTest.*
ArithmeticTest.exe --gtest_filter=ArithmeticOperationsTest.Addition_Basic
ArithmeticTest.exe --gtest_filter=ArithmeticOperationsTest.Addition*
ArithmeticTest.exe --gtest_filter=-ArithmeticOperationsTest.Division_ThrowsWhenZero

// Microsoft Style
ArithmeticTest.exe --gtest_filter=TestArithmeticOperations.*
ArithmeticTest.exe --gtest_filter=TestArithmeticOperations.Addition_Basic
ArithmeticTest.exe --gtest_filter=TestArithmeticOperations.Addition*
ArithmeticTest.exe --gtest_filter=-TestArithmeticOperations.Division_ThrowsWhenZero
```

---

## 16. 전체 비교 요약표

| 항목 | Google Style | Microsoft Style |
|---|---|---|
| **루트 폴더명 (레포명)** | `arithmetic_operations` | `ArithmeticOperations` |
| **일반 폴더명** | `snake_case` | `snake_case` |
| **외부 라이브러리 폴더** | `third_party/` | `external/` |
| **파일명** | `snake_case.cc` | `PascalCase.cpp` |
| **테스트 파일명** | `snake_case_test.cc` | `TestPascalCase.cpp` |
| **클래스명** | `PascalCase` | `PascalCase` |
| **메서드명** | `PascalCase` | `PascalCase` |
| **getter** | `snake_case()` | `GetXxx()` |
| **setter** | `set_xxx()` | `SetXxx()` |
| **지역 변수** | `snake_case` | `camelCase` |
| **멤버 변수** | `snake_case_` | `m_camelCase` |
| **정적 멤버 변수** | `s_snake_case_` | `s_camelCase` |
| **전역 변수** | `g_snake_case` | `g_camelCase` |
| **상수** | `kPascalCase` | `ALL_CAPS` |
| **네임스페이스** | `snake_case` | `PascalCase` |
| **헤더 가드** | `FILENAME_H_` | `#pragma once` |
| **인터페이스** | `PascalCase` | `IPascalCase` |
| **테스트 스위트명** | `클래스명 + Test` | `Test + 클래스명` |
| **테스트 케이스명** | `메서드명_시나리오` | `메서드명_시나리오` (동일) |
| **Fixture 클래스명** | `클래스명 + Test` | `Test + 클래스명` |
| **Fixture 멤버 변수** | `snake_case_` | `m_camelCase` |

---

## 17. 사칙연산 예제 전체 적용 비교

### Google Style — arithmetic_operations.h

```cpp
#ifndef ARITHMETIC_OPERATIONS_H_
#define ARITHMETIC_OPERATIONS_H_

class ArithmeticOperations {
public:
    int Addition(int x, int y);
    int Subtraction(int x, int y);
    int Multiplication(int x, int y);
    int Division(int x, int y);
    float Quotient(int x, int y);

    int last_result() const { return last_result_; }
    void set_last_result(int result) { last_result_ = result; }

private:
    int last_result_ = 0;
};

#endif  // ARITHMETIC_OPERATIONS_H_
```

### Microsoft Style — ArithmeticOperations.h

```cpp
#pragma once

class ArithmeticOperations {
public:
    int Addition(int x, int y);
    int Subtraction(int x, int y);
    int Multiplication(int x, int y);
    int Division(int x, int y);
    float Quotient(int x, int y);

    int GetLastResult() const { return m_lastResult; }
    void SetLastResult(int result) { m_lastResult = result; }

private:
    int m_lastResult = 0;
};
```

---

## 18. 핵심 차이 한 줄 요약

```
루트 폴더명   : Google = arithmetic_operations  / Microsoft = ArithmeticOperations
외부 라이브러리: Google = third_party/           / Microsoft = external/
파일명        : Google = snake_case.cc           / Microsoft = PascalCase.cpp
테스트 파일명 : Google = plus_test.cc            / Microsoft = TestPlus.cpp
클래스명      : Google = Microsoft 동일          (PascalCase)
메서드명      : Google = Microsoft 동일          (PascalCase)
getter        : Google = snake_case()            / Microsoft = GetXxx()
setter        : Google = set_xxx()               / Microsoft = SetXxx()
지역 변수     : Google = snake_case              / Microsoft = camelCase
멤버 변수     : Google = snake_case_             / Microsoft = m_camelCase
상수          : Google = kPascalCase             / Microsoft = ALL_CAPS
네임스페이스  : Google = snake_case              / Microsoft = PascalCase
테스트 스위트 : Google = PlusTest                / Microsoft = TestPlus
테스트 케이스 : Google = Microsoft 동일          (Addition_Basic)
Fixture 변수  : Google = ao_                     / Microsoft = m_ao
```
