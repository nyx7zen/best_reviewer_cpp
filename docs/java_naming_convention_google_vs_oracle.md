# Java 네이밍 Convention — Google vs Oracle 비교

---

## 1. 기본 원칙

| 원칙 | 내용 |
|---|---|
| 일관성 | 프로젝트 내에서 한 가지 스타일을 선택하고 끝까지 유지 |
| 명확성 | 이름만 보고 역할을 즉시 파악할 수 있어야 함 |
| 축약 금지 | `calc` 보다 `calculator`, `ao` 보다 `arithmeticOperations` 권장 |
| 팀 합의 | 개인 선호보다 팀 기준이 우선 |

### 두 가이드 출처

| 항목 | Google Java Style Guide | Oracle Java Code Conventions |
|---|---|---|
| 출처 | google.github.io/styleguide/javaguide.html | oracle.com/java/technologies/javase/codeconventions |
| 최종 갱신 | 지속 업데이트 | 1999년 (마지막 공식 갱신) |
| 강제성 | Google 내부 필수, 외부 권장 | Java 진영 사실상 표준 |
| 사용 범위 | Google 계열 프로젝트, Android | Oracle JDK, 대부분의 Java 프로젝트 |

---

## 2. 폴더명

Java 는 Maven / Gradle 표준 폴더 구조를 따르는 것이 일반적이며 두 스타일 모두 동일합니다.

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 소스 폴더 | `src/main/java` | `src/main/java` |
| 테스트 폴더 | `src/test/java` | `src/test/java` |
| 리소스 폴더 | `src/main/resources` | `src/main/resources` |
| 빌드 폴더 | `target` (Maven) / `build` (Gradle) | `target` (Maven) / `build` (Gradle) |
| 일반 폴더명 | `lowercase` | `lowercase` |

### 사칙연산 예제 — Maven 표준 구조

```
arithmetic-operations/              <- 루트 (레포명) — kebab-case (공통)
  src/
    main/
      java/
        com/example/arithmetic/
          Plus.java
          Minus.java
          ArithmeticOperations.java
          Main.java
    test/
      java/
        com/example/arithmetic/
          PlusTest.java             <- Google Style
          MinusTest.java            <- Google Style
          ArithmeticOperationsTest.java
  pom.xml                           <- Maven 빌드 설정
  .gitignore
  README.md
```

---

## 3. 프로젝트 폴더 구조

폴더 구조는 두 스타일 모두 Maven / Gradle 표준을 따르므로 동일합니다.

### Google Style / Oracle Style 공통 구조

```
arithmetic-operations/
  src/
    main/
      java/
        com/example/arithmetic/     <- 패키지 경로 (도메인 역순)
          Plus.java
          Minus.java
          ArithmeticOperations.java
          Main.java
    test/
      java/
        com/example/arithmetic/     <- 소스와 동일한 패키지 경로
          PlusTest.java
          MinusTest.java
          ArithmeticOperationsTest.java
  target/                           <- 빌드 산출물 (gitignore)
  pom.xml
  .gitignore
  README.md
```

### 두 스타일 차이가 나는 항목

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 루트 폴더명 (레포명) | `arithmetic-operations` (kebab-case) | `arithmetic-operations` (kebab-case) |
| 테스트 파일명 | `PlusTest.java` | 명시 없음 (관례상 `PlusTest.java`) |
| 들여쓰기 | 2 spaces | 4 spaces |
| 최대 줄 길이 | 100자 | 80자 |

---

## 4. 파일명

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 소스 파일 | `PascalCase.java` | `PascalCase.java` |
| 테스트 파일 | `클래스명Test.java` | 명시 없음 (관례상 `클래스명Test.java`) |
| 파일명 규칙 | 최상위 클래스명과 동일 | 최상위 클래스명과 동일 |

두 스타일 모두 파일명은 PascalCase 로 동일합니다.

### 사칙연산 예제

| 파일 역할 | Google Style | Oracle Style |
|---|---|---|
| Plus 클래스 | `Plus.java` | `Plus.java` |
| Minus 클래스 | `Minus.java` | `Minus.java` |
| ArithmeticOperations 클래스 | `ArithmeticOperations.java` | `ArithmeticOperations.java` |
| Plus 테스트 | `PlusTest.java` | `PlusTest.java` (관례) |
| Minus 테스트 | `MinusTest.java` | `MinusTest.java` (관례) |
| ArithmeticOperations 테스트 | `ArithmeticOperationsTest.java` | `ArithmeticOperationsTest.java` |

---

## 5. 변수명

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 지역 변수 | `camelCase` | `camelCase` |
| 인스턴스 변수 | `camelCase` (접두/접미사 없음) | `camelCase` (접두/접미사 없음) |
| 정적 변수 | `camelCase` | `camelCase` |
| 상수 | `UPPER_SNAKE_CASE` | `UPPER_SNAKE_CASE` |
| 임시 변수 | `i`, `j`, `k` (루프 카운터) | `i`, `j`, `k` (루프 카운터) |
| 멤버 변수 접두사 | 없음 (m_, _ 금지) | 없음 |

두 스타일 모두 변수명은 동일합니다. Google Style 은 `m_`, `_` 접두/접미사를 명시적으로 금지합니다.

### 사칙연산 예제

```java
// Google Style / Oracle Style 동일
int firstNumber = 4;                // 지역 변수 — camelCase
int secondNumber = 2;
private int lastResult = 0;         // 인스턴스 변수 — camelCase (접두사 없음)
private static int callCount = 0;   // 정적 변수 — camelCase
public static final int MAX_VALUE = 1000;  // 상수 — UPPER_SNAKE_CASE
```

### C++ 와의 차이

| 항목 | Java (Google/Oracle 공통) | C++ Google Style | C++ Microsoft Style |
|---|---|---|---|
| 멤버 변수 | `camelCase` (접두/접미사 없음) | `snake_case_` (접미사 `_`) | `m_camelCase` (접두사 `m_`) |
| 상수 | `UPPER_SNAKE_CASE` | `kPascalCase` | `ALL_CAPS` |

---

## 6. 함수명 (메서드명)

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 일반 메서드 | `camelCase` (소문자 시작) | `camelCase` (소문자 시작) |
| getter | `getXxx()` | `getXxx()` |
| setter | `setXxx()` | `setXxx()` |
| boolean getter | `isXxx()`, `hasXxx()` | `isXxx()`, `hasXxx()` |
| 정적 팩토리 메서드 | `of()`, `from()`, `create()` | `of()`, `from()`, `create()` |

두 스타일 모두 메서드명은 camelCase 로 동일합니다.

### 사칙연산 예제

```java
// Google Style / Oracle Style 동일
public int addition(int x, int y) { ... }
public int subtraction(int x, int y) { ... }
public int multiplication(int x, int y) { ... }
public int division(int x, int y) { ... }
public float quotient(int x, int y) { ... }

// getter / setter
public int getLastResult() { return lastResult; }
public void setLastResult(int result) { this.lastResult = result; }
```

### C++ 와의 차이

| 항목 | Java (공통) | C++ Google Style | C++ Microsoft Style |
|---|---|---|---|
| 일반 메서드 | `camelCase` — `addition()` | `PascalCase` — `Addition()` | `PascalCase` — `Addition()` |
| getter | `getXxx()` | `snake_case()` — `last_result()` | `GetXxx()` — `GetLastResult()` |
| setter | `setXxx()` | `set_xxx()` — `set_last_result()` | `SetXxx()` — `SetLastResult()` |

---

## 7. 클래스명

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 클래스명 | `PascalCase` | `PascalCase` |
| 인터페이스명 | `PascalCase` | `PascalCase` |
| 추상 클래스 | `PascalCase` (Abstract 접두사 선택) | `PascalCase` |
| 열거형 | `PascalCase` | `PascalCase` |
| 어노테이션 | `PascalCase` | `PascalCase` |
| 예외 클래스 | `PascalCase + Exception` | `PascalCase + Exception` |

두 스타일 모두 클래스명은 PascalCase 로 동일합니다.

### 사칙연산 예제

```java
// Google Style / Oracle Style 동일
public class Plus { }
public class Minus { }
public class ArithmeticOperations { }
public class ArithmeticException extends RuntimeException { }
public interface Calculable { }
```

---

## 8. 패키지명

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 패키지명 | `lowercase` (모두 소문자) | `lowercase` (모두 소문자) |
| 구분자 | `.` (점) | `.` (점) |
| 도메인 역순 | `com.example.arithmetic` | `com.example.arithmetic` |
| 언더스코어 | 가급적 사용하지 않음 | 필요 시 사용 가능 |

두 스타일 모두 패키지명은 동일합니다.

### 사칙연산 예제

```java
// Google Style / Oracle Style 동일
package com.example.arithmetic;
package com.google.search.common;
package com.company.arithmetic.operations;
```

---

## 9. 들여쓰기 및 포맷 차이

두 스타일에서 가장 눈에 띄는 차이는 들여쓰기와 줄 길이입니다.

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 들여쓰기 | **2 spaces** | **4 spaces** |
| 최대 줄 길이 | **100자** | **80자** |
| 중괄호 | K&R 스타일 (같은 줄) | K&R 스타일 (같은 줄) |
| 와일드카드 import | **금지** | 허용 |
| static import | 제한적 허용 | 허용 |

### 예시 — 들여쓰기 차이

```java
// Google Style — 2 spaces
public class ArithmeticOperations {
  private int lastResult = 0;

  public int addition(int x, int y) {
    lastResult = x + y;
    return lastResult;
  }
}

// Oracle Style — 4 spaces
public class ArithmeticOperations {
    private int lastResult = 0;

    public int addition(int x, int y) {
        lastResult = x + y;
        return lastResult;
    }
}
```

---

## 10. 테스트 파일명 및 테스트 클래스명

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 테스트 파일명 | `클래스명Test.java` | 명시 없음 (관례상 `클래스명Test.java`) |
| 테스트 클래스명 | `클래스명Test` | 명시 없음 (관례상 `클래스명Test`) |
| 통합 테스트 클래스명 | `클래스명IntegrationTest` | 명시 없음 |

두 스타일 모두 테스트 클래스명은 `클래스명 + Test` 접미사가 사실상 표준입니다.

### 사칙연산 예제

```java
// Google Style / Oracle Style 동일
PlusTest.java                   // Plus 클래스 테스트
MinusTest.java                  // Minus 클래스 테스트
ArithmeticOperationsTest.java   // ArithmeticOperations 클래스 테스트
```

---

## 11. 테스트 케이스명 (메서드명)

| 항목 | Google Style | Oracle Style |
|---|---|---|
| 테스트 메서드명 | `camelCase` 또는 `메서드명_상태` | 명시 없음 (관례상 `camelCase`) |
| 구분자 | `_` (언더스코어) 허용 | 명시 없음 |
| 패턴 | `메서드명_상태` (`transferMoney_deductsFromSource`) | `test + 메서드명` 또는 자유 |

Google Style 은 JUnit 테스트 메서드명에서 `_` 사용을 허용합니다. Oracle 은 명시적 규칙이 없어 `testXxx` 패턴이 관례적으로 사용되기도 합니다.

### 사칙연산 예제

```java
// Google Style — 메서드명_상태 패턴
@Test
void addition_withPositiveNumbers() { ... }

@Test
void addition_withNegativeNumbers() { ... }

@Test
void addition_withZero() { ... }

@Test
void division_throwsWhenDivisorIsZero() { ... }

@Test
void quotient_returnsFloat() { ... }

// Oracle / 관례 패턴 — testXxx 또는 camelCase
@Test
void testAdditionWithPositiveNumbers() { ... }

@Test
void testDivisionByZero() { ... }
```

---

## 12. TEST 전체 코드 비교 — 사칙연산 예제

### Google Style — ArithmeticOperationsTest.java

```java
package com.example.arithmetic;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;

class ArithmeticOperationsTest {

  private ArithmeticOperations ao;  // 들여쓰기 2 spaces, 접두사 없음

  @BeforeEach
  void setUp() {
    ao = new ArithmeticOperations();
  }

  @Test
  void addition_withPositiveNumbers() {
    assertEquals(6, ao.addition(4, 2));
  }

  @Test
  void addition_withNegativeNumbers() {
    assertEquals(-11, ao.addition(-1, -10));
  }

  @Test
  void addition_withZero() {
    assertEquals(0, ao.addition(0, 0));
  }

  @Test
  void division_basic() {
    assertEquals(2, ao.division(4, 2));
  }

  @Test
  void division_throwsWhenDivisorIsZero() {
    assertThrows(ArithmeticException.class, () -> ao.division(4, 0));
  }

  @Test
  void quotient_returnsFloat() {
    assertEquals(2.5f, ao.quotient(5, 2), 0.001f);
  }
}
```

### Oracle Style — ArithmeticOperationsTest.java

```java
package com.example.arithmetic;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;

class ArithmeticOperationsTest {

    private ArithmeticOperations ao;    // 들여쓰기 4 spaces, 접두사 없음

    @BeforeEach
    void setUp() {
        ao = new ArithmeticOperations();
    }

    @Test
    void testAdditionWithPositiveNumbers() {
        assertEquals(6, ao.addition(4, 2));
    }

    @Test
    void testAdditionWithNegativeNumbers() {
        assertEquals(-11, ao.addition(-1, -10));
    }

    @Test
    void testAdditionWithZero() {
        assertEquals(0, ao.addition(0, 0));
    }

    @Test
    void testDivisionBasic() {
        assertEquals(2, ao.division(4, 2));
    }

    @Test
    void testDivisionByZero() {
        assertThrows(ArithmeticException.class, () -> ao.division(4, 0));
    }

    @Test
    void testQuotientReturnsFloat() {
        assertEquals(2.5f, ao.quotient(5, 2), 0.001f);
    }
}
```

---

## 13. 클래스 전체 코드 비교 — 사칙연산 예제

### Google Style — ArithmeticOperations.java

```java
package com.example.arithmetic;

public class ArithmeticOperations {  // 들여쓰기 2 spaces

  private int lastResult = 0;        // 접두사 없음

  public int addition(int x, int y) {
    lastResult = x + y;
    return lastResult;
  }

  public int subtraction(int x, int y) {
    lastResult = x - y;
    return lastResult;
  }

  public int multiplication(int x, int y) {
    lastResult = x * y;
    return lastResult;
  }

  public int division(int x, int y) {
    if (y == 0) {
      throw new ArithmeticException("Division by zero");
    }
    lastResult = x / y;
    return lastResult;
  }

  public float quotient(int x, int y) {
    if (y == 0) {
      throw new ArithmeticException("Division by zero");
    }
    return (float) x / y;
  }

  // getter — camelCase (getXxx)
  public int getLastResult() {
    return lastResult;
  }

  // setter — camelCase (setXxx)
  public void setLastResult(int lastResult) {
    this.lastResult = lastResult;
  }
}
```

### Oracle Style — ArithmeticOperations.java

```java
package com.example.arithmetic;

public class ArithmeticOperations {    // 들여쓰기 4 spaces

    private int lastResult = 0;        // 접두사 없음

    public int addition(int x, int y) {
        lastResult = x + y;
        return lastResult;
    }

    public int subtraction(int x, int y) {
        lastResult = x - y;
        return lastResult;
    }

    public int multiplication(int x, int y) {
        lastResult = x * y;
        return lastResult;
    }

    public int division(int x, int y) {
        if (y == 0) {
            throw new ArithmeticException("Division by zero");
        }
        lastResult = x / y;
        return lastResult;
    }

    public float quotient(int x, int y) {
        if (y == 0) {
            throw new ArithmeticException("Division by zero");
        }
        return (float) x / y;
    }

    // getter — camelCase (getXxx)
    public int getLastResult() {
        return lastResult;
    }

    // setter — camelCase (setXxx)
    public void setLastResult(int lastResult) {
        this.lastResult = lastResult;
    }
}
```

---

## 14. 전체 비교 요약표

| 항목 | Google Style | Oracle Style |
|---|---|---|
| **루트 폴더명** | `arithmetic-operations` | `arithmetic-operations` |
| **폴더 구조** | Maven/Gradle 표준 | Maven/Gradle 표준 |
| **파일명** | `PascalCase.java` | `PascalCase.java` |
| **테스트 파일명** | `클래스명Test.java` | `클래스명Test.java` (관례) |
| **클래스명** | `PascalCase` | `PascalCase` |
| **메서드명** | `camelCase` | `camelCase` |
| **getter** | `getXxx()` | `getXxx()` |
| **setter** | `setXxx()` | `setXxx()` |
| **변수명** | `camelCase` (접두/접미사 없음) | `camelCase` (접두/접미사 없음) |
| **상수** | `UPPER_SNAKE_CASE` | `UPPER_SNAKE_CASE` |
| **패키지명** | `lowercase` | `lowercase` |
| **들여쓰기** | **2 spaces** | **4 spaces** |
| **최대 줄 길이** | **100자** | **80자** |
| **와일드카드 import** | **금지** | 허용 |
| **멤버 변수 접두사** | **없음 (m_, _ 금지)** | 없음 |
| **테스트 클래스명** | `클래스명Test` | `클래스명Test` (관례) |
| **테스트 메서드명** | `메서드명_상태` | `testXxx` (관례) |

---

## 15. Java vs C++ 네이밍 핵심 차이

Java 개발자가 C++ 을 처음 접하거나 C++ 개발자가 Java 를 처음 접할 때 혼동하기 쉬운 차이점입니다.

| 항목 | Java (Google/Oracle 공통) | C++ Google Style | C++ Microsoft Style |
|---|---|---|---|
| 메서드명 | `camelCase` `addition()` | `PascalCase` `Addition()` | `PascalCase` `Addition()` |
| getter | `getLastResult()` | `last_result()` | `GetLastResult()` |
| setter | `setLastResult()` | `set_last_result()` | `SetLastResult()` |
| 멤버 변수 | `lastResult` | `last_result_` | `m_lastResult` |
| 상수 | `MAX_VALUE` | `kMaxValue` | `MAX_VALUE` |
| 파일 확장자 | `.java` | `.cc` / `.h` | `.cpp` / `.h` |
| 테스트 파일명 | `ArithmeticOperationsTest.java` | `arithmetic_operations_test.cc` | `TestArithmeticOperations.cpp` |
| 테스트 클래스명 | `ArithmeticOperationsTest` | `ArithmeticOperationsTest` | `TestArithmeticOperations` |

---

## 16. 핵심 차이 한 줄 요약

```
파일명        : Google = Oracle 동일              (PascalCase.java)
클래스명      : Google = Oracle 동일              (PascalCase)
메서드명      : Google = Oracle 동일              (camelCase)
getter        : Google = Oracle 동일              (getXxx)
setter        : Google = Oracle 동일              (setXxx)
변수명        : Google = Oracle 동일              (camelCase, 접두/접미사 없음)
상수          : Google = Oracle 동일              (UPPER_SNAKE_CASE)
패키지명      : Google = Oracle 동일              (lowercase)
들여쓰기      : Google = 2 spaces                 / Oracle = 4 spaces
줄 길이       : Google = 100자                    / Oracle = 80자
import        : Google = 와일드카드 금지           / Oracle = 허용
테스트 클래스 : Google = PlusTest                 / Oracle = PlusTest (관례, 동일)
테스트 메서드 : Google = addition_withZero()      / Oracle = testAdditionWithZero()
```
