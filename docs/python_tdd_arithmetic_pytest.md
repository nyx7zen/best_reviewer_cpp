# Python pytest TDD — 사칙연산 예제

---

## 1. 프로젝트 폴더 구조

```
arithmetic_operations/              <- 루트 (레포명)
  arithmetic/                       <- 패키지 폴더
    __init__.py
    plus.py
    minus.py
    multiplication.py
    division.py
    arithmetic_operations.py        <- 통합 클래스
  tests/
    __init__.py
    test_plus.py
    test_minus.py
    test_multiplication.py
    test_division.py
    test_arithmetic_operations.py   <- 통합 테스트
  .gitignore
  requirements.txt
  pytest.ini                        <- pytest 설정
  README.md
```

---

## 2. 설정 파일

**requirements.txt**
```
pytest
pytest-cov
```

**pytest.ini**
```ini
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --tb=short
```

**.gitignore**
```
__pycache__/
*.pyc
.pytest_cache/
htmlcov/
.coverage
```

---

## 3. 소스 파일

**arithmetic/__init__.py**
```python
from .plus import Plus
from .minus import Minus
from .multiplication import Multiplication
from .division import Division
from .arithmetic_operations import ArithmeticOperations
```

**arithmetic/plus.py**
```python
class Plus:
    """덧셈 클래스."""

    @staticmethod
    def run(x: int, y: int) -> int:
        """두 정수를 더한다.

        Args:
            x: 첫 번째 정수.
            y: 두 번째 정수.

        Returns:
            x + y 결과.
        """
        return x + y
```

**arithmetic/minus.py**
```python
class Minus:
    """뺄셈 클래스."""

    @staticmethod
    def run(x: int, y: int) -> int:
        """두 정수를 뺀다.

        Args:
            x: 피감수.
            y: 감수.

        Returns:
            x - y 결과.
        """
        return x - y
```

**arithmetic/multiplication.py**
```python
class Multiplication:
    """곱셈 클래스."""

    @staticmethod
    def run(x: int, y: int) -> int:
        """두 정수를 곱한다.

        Args:
            x: 첫 번째 정수.
            y: 두 번째 정수.

        Returns:
            x * y 결과.
        """
        return x * y
```

**arithmetic/division.py**
```python
class Division:
    """나눗셈 클래스."""

    @staticmethod
    def run(x: int, y: int) -> int:
        """두 정수를 나눈다 (몫).

        Args:
            x: 피제수.
            y: 제수. 0 이면 ValueError 발생.

        Returns:
            x // y 정수 몫.

        Raises:
            ValueError: y 가 0 인 경우.
        """
        if y == 0:
            raise ValueError("Division by zero")
        return x // y

    @staticmethod
    def quotient(x: int, y: int) -> float:
        """두 정수를 나눈다 (실수 몫).

        Args:
            x: 피제수.
            y: 제수. 0 이면 ValueError 발생.

        Returns:
            x / y 실수 몫.

        Raises:
            ValueError: y 가 0 인 경우.
        """
        if y == 0:
            raise ValueError("Division by zero")
        return x / y
```

**arithmetic/arithmetic_operations.py**
```python
from .plus import Plus
from .minus import Minus
from .multiplication import Multiplication
from .division import Division


class ArithmeticOperations:
    """사칙연산 통합 클래스."""

    def __init__(self):
        self._last_result: float = 0.0

    def addition(self, x: int, y: int) -> int:
        result = Plus.run(x, y)
        self._last_result = result
        return result

    def subtraction(self, x: int, y: int) -> int:
        result = Minus.run(x, y)
        self._last_result = result
        return result

    def multiplication(self, x: int, y: int) -> int:
        result = Multiplication.run(x, y)
        self._last_result = result
        return result

    def division(self, x: int, y: int) -> int:
        result = Division.run(x, y)
        self._last_result = result
        return result

    def quotient(self, x: int, y: int) -> float:
        result = Division.quotient(x, y)
        self._last_result = result
        return result

    @property
    def last_result(self) -> float:
        return self._last_result
```

---

## 4. 테스트 파일 — 클래스 기반 vs 함수 기반 비교

### 4-1. Plus 테스트

**클래스 기반 — tests/test_plus.py**
```python
import pytest
from arithmetic.plus import Plus


class TestPlus:
    """Plus 클래스 테스트."""

    # --- RED: 실패하는 테스트 먼저 작성 ---

    def test_run_with_positive_numbers(self):
        # Arrange
        x, y = 4, 2
        # Act
        result = Plus.run(x, y)
        # Assert
        assert result == 6

    def test_run_with_negative_numbers(self):
        assert Plus.run(-1, -10) == -11

    def test_run_with_zero(self):
        assert Plus.run(0, 0) == 0

    def test_run_with_mixed_sign(self):
        assert Plus.run(-5, 3) == -2

    def test_run_large_numbers(self):
        assert Plus.run(1_000_000, 2_000_000) == 3_000_000

    def test_run_returns_int(self):
        result = Plus.run(1, 2)
        assert isinstance(result, int)
```

**함수 기반 — tests/test_plus.py**
```python
import pytest
from arithmetic.plus import Plus


def test_plus_run_with_positive_numbers():
    # Arrange
    x, y = 4, 2
    # Act
    result = Plus.run(x, y)
    # Assert
    assert result == 6


def test_plus_run_with_negative_numbers():
    assert Plus.run(-1, -10) == -11


def test_plus_run_with_zero():
    assert Plus.run(0, 0) == 0


def test_plus_run_with_mixed_sign():
    assert Plus.run(-5, 3) == -2


def test_plus_run_large_numbers():
    assert Plus.run(1_000_000, 2_000_000) == 3_000_000


def test_plus_run_returns_int():
    result = Plus.run(1, 2)
    assert isinstance(result, int)
```

---

### 4-2. Division 테스트 (예외 포함)

**클래스 기반 — tests/test_division.py**
```python
import pytest
from arithmetic.division import Division


class TestDivision:
    """Division 클래스 테스트."""

    # --- run (정수 몫) ---

    def test_run_basic(self):
        assert Division.run(4, 2) == 2

    def test_run_with_negative(self):
        assert Division.run(-10, 2) == -5

    def test_run_result_is_integer_quotient(self):
        assert Division.run(5, 2) == 2   # 실수 아닌 정수 몫

    def test_run_raises_when_divisor_is_zero(self):
        with pytest.raises(ValueError):
            Division.run(4, 0)

    def test_run_raises_value_error_message(self):
        with pytest.raises(ValueError, match="Division by zero"):
            Division.run(4, 0)

    def test_run_zero_dividend(self):
        assert Division.run(0, 5) == 0

    # --- quotient (실수 몫) ---

    def test_quotient_basic(self):
        assert Division.quotient(5, 2) == pytest.approx(2.5)

    def test_quotient_with_negative(self):
        assert Division.quotient(-10, 2) == pytest.approx(-5.0)

    def test_quotient_returns_float(self):
        result = Division.quotient(5, 2)
        assert isinstance(result, float)

    def test_quotient_raises_when_divisor_is_zero(self):
        with pytest.raises(ValueError):
            Division.quotient(4, 0)
```

**함수 기반 — tests/test_division.py**
```python
import pytest
from arithmetic.division import Division


# --- run (정수 몫) ---

def test_division_run_basic():
    assert Division.run(4, 2) == 2


def test_division_run_with_negative():
    assert Division.run(-10, 2) == -5


def test_division_run_result_is_integer_quotient():
    assert Division.run(5, 2) == 2


def test_division_run_raises_when_divisor_is_zero():
    with pytest.raises(ValueError):
        Division.run(4, 0)


def test_division_run_raises_value_error_message():
    with pytest.raises(ValueError, match="Division by zero"):
        Division.run(4, 0)


def test_division_run_zero_dividend():
    assert Division.run(0, 5) == 0


# --- quotient (실수 몫) ---

def test_division_quotient_basic():
    assert Division.quotient(5, 2) == pytest.approx(2.5)


def test_division_quotient_with_negative():
    assert Division.quotient(-10, 2) == pytest.approx(-5.0)


def test_division_quotient_returns_float():
    result = Division.quotient(5, 2)
    assert isinstance(result, float)


def test_division_quotient_raises_when_divisor_is_zero():
    with pytest.raises(ValueError):
        Division.quotient(4, 0)
```

---

### 4-3. ArithmeticOperations 통합 테스트 — Fixture 활용

**클래스 기반 — tests/test_arithmetic_operations.py**
```python
import pytest
from arithmetic.arithmetic_operations import ArithmeticOperations


class TestArithmeticOperations:
    """ArithmeticOperations 통합 테스트."""

    @pytest.fixture(autouse=True)
    def setup(self):
        """각 테스트 실행 전 초기화."""
        self.ao = ArithmeticOperations()

    # --- addition ---

    def test_addition_basic(self):
        assert self.ao.addition(4, 2) == 6

    def test_addition_negative(self):
        assert self.ao.addition(-1, -10) == -11

    def test_addition_zero(self):
        assert self.ao.addition(0, 0) == 0

    # --- subtraction ---

    def test_subtraction_basic(self):
        assert self.ao.subtraction(4, 2) == 2

    def test_subtraction_result_negative(self):
        assert self.ao.subtraction(2, 5) == -3

    # --- multiplication ---

    def test_multiplication_basic(self):
        assert self.ao.multiplication(4, 2) == 8

    def test_multiplication_negative(self):
        assert self.ao.multiplication(-5, -3) == 15

    def test_multiplication_zero(self):
        assert self.ao.multiplication(0, 10) == 0

    # --- division ---

    def test_division_basic(self):
        assert self.ao.division(4, 2) == 2

    def test_division_raises_when_zero(self):
        with pytest.raises(ValueError):
            self.ao.division(4, 0)

    # --- quotient ---

    def test_quotient_basic(self):
        assert self.ao.quotient(5, 2) == pytest.approx(2.5)

    def test_quotient_raises_when_zero(self):
        with pytest.raises(ValueError):
            self.ao.quotient(4, 0)

    # --- last_result property ---

    def test_last_result_updated_after_addition(self):
        self.ao.addition(4, 2)
        assert self.ao.last_result == 6

    def test_last_result_updated_after_quotient(self):
        self.ao.quotient(5, 2)
        assert self.ao.last_result == pytest.approx(2.5)
```

**함수 기반 — tests/test_arithmetic_operations.py**
```python
import pytest
from arithmetic.arithmetic_operations import ArithmeticOperations


# --- pytest fixture ---

@pytest.fixture
def ao():
    """각 테스트에 ArithmeticOperations 인스턴스 제공."""
    return ArithmeticOperations()


# --- addition ---

def test_addition_basic(ao):
    assert ao.addition(4, 2) == 6


def test_addition_negative(ao):
    assert ao.addition(-1, -10) == -11


def test_addition_zero(ao):
    assert ao.addition(0, 0) == 0


# --- subtraction ---

def test_subtraction_basic(ao):
    assert ao.subtraction(4, 2) == 2


def test_subtraction_result_negative(ao):
    assert ao.subtraction(2, 5) == -3


# --- multiplication ---

def test_multiplication_basic(ao):
    assert ao.multiplication(4, 2) == 8


def test_multiplication_negative(ao):
    assert ao.multiplication(-5, -3) == 15


def test_multiplication_zero(ao):
    assert ao.multiplication(0, 10) == 0


# --- division ---

def test_division_basic(ao):
    assert ao.division(4, 2) == 2


def test_division_raises_when_zero(ao):
    with pytest.raises(ValueError):
        ao.division(4, 0)


# --- quotient ---

def test_quotient_basic(ao):
    assert ao.quotient(5, 2) == pytest.approx(2.5)


def test_quotient_raises_when_zero(ao):
    with pytest.raises(ValueError):
        ao.quotient(4, 0)


# --- last_result property ---

def test_last_result_updated_after_addition(ao):
    ao.addition(4, 2)
    assert ao.last_result == 6


def test_last_result_updated_after_quotient(ao):
    ao.quotient(5, 2)
    assert ao.last_result == pytest.approx(2.5)
```

---

## 5. 파라미터화 테스트 (pytest.mark.parametrize)

클래스 기반과 함수 기반 모두 동일한 방식으로 사용합니다.

**클래스 기반**
```python
import pytest
from arithmetic.plus import Plus
from arithmetic.division import Division


class TestPlusParametrize:
    """파라미터화 테스트."""

    @pytest.mark.parametrize("x, y, expected", [
        (4, 2, 6),
        (-1, -10, -11),
        (0, 0, 0),
        (-5, 3, -2),
        (100, 200, 300),
    ])
    def test_run(self, x, y, expected):
        assert Plus.run(x, y) == expected

    @pytest.mark.parametrize("x, y", [
        (4, 0),
        (0, 0),
        (-10, 0),
    ])
    def test_division_raises_when_zero(self, x, y):
        with pytest.raises(ValueError):
            Division.run(x, y)
```

**함수 기반**
```python
import pytest
from arithmetic.plus import Plus
from arithmetic.division import Division


@pytest.mark.parametrize("x, y, expected", [
    (4, 2, 6),
    (-1, -10, -11),
    (0, 0, 0),
    (-5, 3, -2),
    (100, 200, 300),
])
def test_plus_run(x, y, expected):
    assert Plus.run(x, y) == expected


@pytest.mark.parametrize("x, y", [
    (4, 0),
    (0, 0),
    (-10, 0),
])
def test_division_raises_when_zero(x, y):
    with pytest.raises(ValueError):
        Division.run(x, y)
```

---

## 6. 클래스 기반 vs 함수 기반 비교

| 항목 | 클래스 기반 | 함수 기반 |
|---|---|---|
| 테스트 클래스명 | `class TestPlus:` | 없음 |
| 테스트 함수명 | `def test_run_basic(self):` | `def test_plus_run_basic():` |
| 초기화 방식 | `@pytest.fixture(autouse=True)` 또는 `setup_method` | `@pytest.fixture` + 인자로 주입 |
| 상태 공유 | `self.ao` 로 인스턴스 공유 | fixture 를 인자로 주입 |
| 코드 중복 | 클래스로 그룹화하여 줄임 | 함수명에 접두사로 구분 |
| 가독성 | 그룹이 명확 | 개별 함수가 독립적 |
| pytest 권장 | 대규모 그룹 테스트에 적합 | 단순하고 독립적인 테스트에 적합 |
| C++ GoogleTest 대응 | `TEST_F` (Fixture 기반) | `TEST` (독립 테스트) |

### 초기화 방식 비교

| 방식 | 코드 | 설명 |
|---|---|---|
| `setup_method` | `def setup_method(self):` | 각 테스트 메서드 실행 전 호출 |
| `@pytest.fixture(autouse=True)` | 클래스 내 fixture | autouse=True 로 자동 적용 |
| `@pytest.fixture` + 인자 | 함수 기반에서 인자로 주입 | 명시적 의존성 주입 |

```python
# 방식 1 — setup_method (클래스 기반)
class TestArithmeticOperations:
    def setup_method(self):
        self.ao = ArithmeticOperations()

    def test_addition_basic(self):
        assert self.ao.addition(4, 2) == 6


# 방식 2 — @pytest.fixture(autouse=True) (클래스 기반)
class TestArithmeticOperations:
    @pytest.fixture(autouse=True)
    def setup(self):
        self.ao = ArithmeticOperations()

    def test_addition_basic(self):
        assert self.ao.addition(4, 2) == 6


# 방식 3 — @pytest.fixture + 인자 주입 (함수 기반)
@pytest.fixture
def ao():
    return ArithmeticOperations()

def test_addition_basic(ao):
    assert ao.addition(4, 2) == 6
```

---

## 7. TDD RED / GREEN / REFACTOR 사이클

### RED — 실패하는 테스트 먼저 작성

```python
# tests/test_plus.py
def test_plus_run_basic():
    assert Plus.run(4, 2) == 6  # Plus 클래스 아직 없음 → FAIL
```

실행:
```bash
pytest tests/test_plus.py -v
```

결과:
```
FAILED tests/test_plus.py::test_plus_run_basic
ImportError: cannot import name 'Plus'
```

---

### GREEN — 테스트 통과할 최소 코드 구현

```python
# arithmetic/plus.py
class Plus:
    @staticmethod
    def run(x: int, y: int) -> int:
        return x + y  # 최소 구현
```

실행:
```bash
pytest tests/test_plus.py -v
```

결과:
```
PASSED tests/test_plus.py::test_plus_run_basic
```

---

### REFACTOR — 코드 정리 후 테스트 재확인

```python
# arithmetic/plus.py — docstring 및 타입 힌팅 추가
class Plus:
    """덧셈 클래스."""

    @staticmethod
    def run(x: int, y: int) -> int:
        """두 정수를 더한다."""
        return x + y
```

실행:
```bash
pytest tests/test_plus.py -v
```

결과:
```
PASSED tests/test_plus.py::test_plus_run_basic
```

---

## 8. pytest 실행 명령어

```bash
# 전체 테스트 실행
pytest

# 상세 결과 출력
pytest -v

# 특정 파일 실행
pytest tests/test_plus.py

# 특정 클래스 실행
pytest tests/test_arithmetic_operations.py::TestArithmeticOperations

# 특정 함수 실행
pytest tests/test_arithmetic_operations.py::test_addition_basic

# 키워드로 필터링
pytest -k "addition"
pytest -k "zero"
pytest -k "not zero"

# 실패 즉시 중단
pytest -x

# 처음 3개 실패 후 중단
pytest --maxfail=3

# 커버리지 측정
pytest --cov=arithmetic --cov-report=term-missing

# 커버리지 HTML 리포트 생성
pytest --cov=arithmetic --cov-report=html
```

---

## 9. pytest 실행 결과 예시

```
========================= test session starts =========================
platform win32 -- Python 3.11.x, pytest-7.x.x
collected 28 items

tests/test_plus.py::TestPlus::test_run_with_positive_numbers PASSED
tests/test_plus.py::TestPlus::test_run_with_negative_numbers PASSED
tests/test_plus.py::TestPlus::test_run_with_zero             PASSED
tests/test_plus.py::TestPlus::test_run_with_mixed_sign       PASSED
tests/test_plus.py::TestPlus::test_run_large_numbers         PASSED
tests/test_plus.py::TestPlus::test_run_returns_int           PASSED
tests/test_division.py::TestDivision::test_run_basic         PASSED
tests/test_division.py::TestDivision::test_run_raises_when_divisor_is_zero PASSED
tests/test_division.py::TestDivision::test_quotient_basic    PASSED
...
========================= 28 passed in 0.12s ==========================
```

---

## 10. C++ GoogleTest vs Python pytest 대응표

| 항목 | C++ GoogleTest | Python pytest 클래스 기반 | Python pytest 함수 기반 |
|---|---|---|---|
| 테스트 정의 | `TEST(Suite, Case)` | `class TestXxx:` + `def test_xxx` | `def test_xxx():` |
| Fixture 정의 | `TEST_F(Fixture, Case)` | `@pytest.fixture(autouse=True)` | `@pytest.fixture` |
| 초기화 | `SetUp()` | `setup_method()` | `@pytest.fixture` 반환값 |
| 정리 | `TearDown()` | `teardown_method()` | `yield` 이후 코드 |
| 동등 비교 | `EXPECT_EQ(6, result)` | `assert result == 6` | `assert result == 6` |
| 예외 검증 | `EXPECT_THROW(...)` | `with pytest.raises(ValueError):` | `with pytest.raises(ValueError):` |
| 부동소수점 | `EXPECT_FLOAT_EQ(2.5f, r)` | `assert r == pytest.approx(2.5)` | `assert r == pytest.approx(2.5)` |
| 파라미터화 | `INSTANTIATE_TEST_SUITE_P` | `@pytest.mark.parametrize` | `@pytest.mark.parametrize` |
| 테스트 실행 | `ctest --output-on-failure` | `pytest -v` | `pytest -v` |
| 커버리지 | `lcov` | `pytest --cov` | `pytest --cov` |
