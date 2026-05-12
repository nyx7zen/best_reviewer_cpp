# Python 네이밍 Convention — PEP8 vs Google Style
## NumPy / PyTorch 관례 포함

---

## 1. 기본 원칙

### Python 의 두 가지 공식 기준

| 항목 | PEP8 | Google Python Style Guide |
|---|---|---|
| 출처 | python.org/dev/peps/pep-0008 | google.github.io/styleguide/pyguide.html |
| 성격 | Python 공식 표준 | Google 내부 표준 (PEP8 기반 확장) |
| 관계 | 기반 표준 | PEP8 을 준수하면서 추가 규칙 적용 |
| 사용 범위 | 모든 Python 프로젝트 | Google 계열, 대규모 팀 프로젝트 |

Google Python Style Guide 는 PEP8 을 기반으로 하며 대부분의 규칙이 동일합니다.
차이는 주로 들여쓰기, 줄 길이, import 방식, docstring 형식에서 나타납니다.

### C++ / Java 와 비교한 Python 의 특징

| 항목 | Python | C++ Google | Java |
|---|---|---|---|
| 변수/함수명 | `snake_case` | `snake_case` (변수) / `PascalCase` (함수) | `camelCase` |
| 클래스명 | `PascalCase` | `PascalCase` | `PascalCase` |
| 상수 | `UPPER_SNAKE_CASE` | `kPascalCase` | `UPPER_SNAKE_CASE` |
| 멤버 변수 접두사 | 없음 (`_` 접두사는 접근 제어용) | `snake_case_` / `m_camelCase` | 없음 |

---

## 2. 폴더명

| 항목 | PEP8 | Google Style |
|---|---|---|
| 패키지 폴더명 | `snake_case` (소문자) | `snake_case` (소문자) |
| 일반 폴더명 | `snake_case` | `snake_case` |
| 테스트 폴더 | `tests/` | `tests/` |

### 사칙연산 예제 폴더 구조

```
arithmetic_operations/          <- 루트 (레포명) — snake_case
  arithmetic/                   <- 패키지 폴더 — snake_case
    __init__.py
    plus.py
    minus.py
    arithmetic_operations.py
  tests/
    __init__.py
    test_plus.py                <- 테스트 파일 — test_ 접두사
    test_minus.py
    test_arithmetic_operations.py
  setup.py
  requirements.txt
  README.md
  .gitignore
```

### PyTorch 프로젝트 폴더 구조

```
my_project/                     <- 루트 — snake_case
  data/                         <- 데이터셋 경로
  datasets/                     <- Dataset 클래스
    __init__.py
    my_dataset.py
  models/                       <- 모델 정의
    __init__.py
    resnet.py
    my_model.py
  losses/                       <- 손실 함수
    __init__.py
    custom_loss.py
  utils/                        <- 유틸리티
    __init__.py
    transforms.py
    metrics.py
  configs/                      <- 설정 파일
    default.yaml
  tests/
    test_dataset.py
    test_model.py
  train.py
  evaluate.py
  requirements.txt
  README.md
```

---

## 3. 파일명

| 항목 | PEP8 | Google Style |
|---|---|---|
| 모듈 파일 | `snake_case.py` | `snake_case.py` |
| 테스트 파일 | `test_모듈명.py` | `test_모듈명.py` |
| 설정 파일 | `snake_case.py` | `snake_case.py` |

### 사칙연산 예제

| 파일 역할 | PEP8 / Google Style |
|---|---|
| Plus 모듈 | `plus.py` |
| Minus 모듈 | `minus.py` |
| ArithmeticOperations 모듈 | `arithmetic_operations.py` |
| Plus 테스트 | `test_plus.py` |
| Minus 테스트 | `test_minus.py` |
| ArithmeticOperations 테스트 | `test_arithmetic_operations.py` |

---

## 4. 변수명

| 항목 | PEP8 | Google Style |
|---|---|---|
| 지역 변수 | `snake_case` | `snake_case` |
| 인스턴스 변수 | `snake_case` | `snake_case` |
| 클래스 변수 | `snake_case` | `snake_case` |
| 상수 | `UPPER_SNAKE_CASE` | `UPPER_SNAKE_CASE` |
| 내부 변수 (private) | `_snake_case` (단일 `_`) | `_snake_case` |
| 강제 private | `__snake_case` (이중 `__`) | 사용 지양 |
| 매직 메서드/변수 | `__name__` (양쪽 `__`) | `__name__` |
| 루프 임시 변수 | `_` (단일 언더스코어) | `_` |

### 사칙연산 예제

```python
# PEP8 / Google Style 동일
first_number = 4            # 지역 변수 — snake_case
second_number = 2
last_result = 0             # 인스턴스 변수 — snake_case (접두사 없음)
_call_count = 0             # 내부 변수 — _snake_case
MAX_VALUE = 1000            # 상수 — UPPER_SNAKE_CASE

# 루프 임시 변수
for _ in range(10):         # 사용하지 않는 변수
    pass

for i, value in enumerate(numbers):  # 인덱스 변수
    pass
```

### NumPy / PyTorch 관례 변수명

```python
import numpy as np
import torch

# NumPy 배열 — 소문자 snake_case
x = np.array([1, 2, 3])
x_train = np.zeros((100, 28, 28))
y_label = np.ones(100)

# PyTorch 텐서 — 소문자 snake_case
x_tensor = torch.tensor([1.0, 2.0, 3.0])
batch_size = 32
learning_rate = 1e-3
num_epochs = 100

# 행렬/텐서 shape 관련 변수 — 대문자 단독 또는 snake_case
N = 100         # 배치 크기
C = 3           # 채널 수
H, W = 224, 224 # 높이, 너비
B, T, D = 32, 128, 512  # Batch, Time, Dimension
```

---

## 5. 함수명

| 항목 | PEP8 | Google Style |
|---|---|---|
| 일반 함수 | `snake_case` | `snake_case` |
| 내부 함수 | `_snake_case` | `_snake_case` |
| 매직 메서드 | `__init__`, `__str__` | `__init__`, `__str__` |

### 사칙연산 예제

```python
# PEP8 / Google Style 동일
def addition(x, y):
    return x + y

def subtraction(x, y):
    return x - y

def multiplication(x, y):
    return x * y

def division(x, y):
    if y == 0:
        raise ValueError("Division by zero")
    return x / y

def quotient(x, y):
    if y == 0:
        raise ValueError("Division by zero")
    return x / y

def _validate_input(x, y):   # 내부 함수 — _ 접두사
    return isinstance(x, int) and isinstance(y, int)
```

### C++ / Java 와의 차이

| 항목 | Python | C++ Google | Java |
|---|---|---|---|
| 함수/메서드명 | `addition()` — snake_case | `Addition()` — PascalCase | `addition()` — camelCase |
| getter | `get_result()` 또는 `result` (property) | `result()` — snake_case | `getResult()` — camelCase |
| setter | `set_result()` 또는 `@result.setter` | `set_result()` | `setResult()` |

---

## 6. 클래스명

| 항목 | PEP8 | Google Style |
|---|---|---|
| 클래스명 | `PascalCase` | `PascalCase` |
| 예외 클래스 | `PascalCase + Error` | `PascalCase + Error` |
| 추상 클래스 | `PascalCase` | `PascalCase` (Abstract 접두사 선택) |
| Mixin 클래스 | `PascalCase + Mixin` | `PascalCase + Mixin` |

### 사칙연산 예제

```python
# PEP8 / Google Style 동일
class Plus:
    pass

class Minus:
    pass

class ArithmeticOperations:
    pass

class DivisionByZeroError(ValueError):  # 예외 — Error 접미사
    pass
```

### PyTorch / NumPy 클래스 관례

```python
import torch
import torch.nn as nn

# PyTorch Dataset 클래스 — PascalCase
class MyDataset(torch.utils.data.Dataset):
    def __init__(self, data_path: str):
        self.data_path = data_path

    def __len__(self):
        return len(self.data)

    def __getitem__(self, idx):
        return self.data[idx]


# PyTorch 모델 클래스 — PascalCase
class ResNetClassifier(nn.Module):
    def __init__(self, num_classes: int = 10):
        super().__init__()
        self.conv1 = nn.Conv2d(3, 64, kernel_size=3)
        self.relu = nn.ReLU()
        self.fc = nn.Linear(64, num_classes)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = self.conv1(x)
        x = self.relu(x)
        return self.fc(x)
```

---

## 7. 클래스 메서드명 및 Property

| 항목 | PEP8 | Google Style |
|---|---|---|
| 일반 메서드 | `snake_case` | `snake_case` |
| getter (property) | `@property` + `snake_case` | `@property` + `snake_case` |
| setter | `@속성명.setter` + `snake_case` | `@속성명.setter` + `snake_case` |
| 정적 메서드 | `@staticmethod` + `snake_case` | `@staticmethod` + `snake_case` |
| 클래스 메서드 | `@classmethod` + `snake_case` | `@classmethod` + `snake_case` |
| 내부 메서드 | `_snake_case` | `_snake_case` |

### 사칙연산 예제 전체 클래스

```python
class ArithmeticOperations:
    """사칙연산 클래스."""

    MAX_VALUE = 1000  # 상수 — UPPER_SNAKE_CASE

    def __init__(self):
        self._last_result = 0   # 내부 변수 — _snake_case

    # 일반 메서드 — snake_case
    def addition(self, x: int, y: int) -> int:
        """두 수를 더한다."""
        self._last_result = x + y
        return self._last_result

    def subtraction(self, x: int, y: int) -> int:
        """두 수를 뺀다."""
        self._last_result = x - y
        return self._last_result

    def multiplication(self, x: int, y: int) -> int:
        """두 수를 곱한다."""
        self._last_result = x * y
        return self._last_result

    def division(self, x: int, y: int) -> int:
        """두 수를 나눈다 (정수)."""
        self._validate_divisor(y)
        self._last_result = x // y
        return self._last_result

    def quotient(self, x: int, y: int) -> float:
        """두 수를 나눈다 (실수)."""
        self._validate_divisor(y)
        return x / y

    # property — getter
    @property
    def last_result(self) -> int:
        return self._last_result

    # property — setter
    @last_result.setter
    def last_result(self, value: int) -> None:
        self._last_result = value

    # 내부 메서드 — _snake_case
    def _validate_divisor(self, y: int) -> None:
        if y == 0:
            raise ValueError("Division by zero")

    # 정적 메서드
    @staticmethod
    def is_valid_input(x: int, y: int) -> bool:
        return isinstance(x, int) and isinstance(y, int)

    # 클래스 메서드
    @classmethod
    def create(cls) -> "ArithmeticOperations":
        return cls()
```

---

## 8. 타입 힌팅 (Type Hints)

PEP8 과 Google Style 모두 타입 힌팅을 강력 권장합니다.

```python
# 기본 타입 힌팅
def addition(x: int, y: int) -> int: ...
def quotient(x: int, y: int) -> float: ...
def get_name() -> str: ...
def is_valid(value: int) -> bool: ...

# NumPy 타입 힌팅
import numpy as np
import numpy.typing as npt

def normalize(x: npt.NDArray[np.float32]) -> npt.NDArray[np.float32]:
    return (x - x.mean()) / x.std()

# PyTorch 타입 힌팅
import torch

def forward(self, x: torch.Tensor) -> torch.Tensor:
    return self.fc(x)

# Optional / Union
from typing import Optional, Union

def division(x: int, y: int) -> Optional[float]:
    if y == 0:
        return None
    return x / y
```

---

## 9. import 관례

| 항목 | PEP8 | Google Style |
|---|---|---|
| import 순서 | 표준 → 서드파티 → 로컬 | 표준 → 서드파티 → 로컬 |
| 와일드카드 import | 지양 (`from x import *`) | 금지 |
| 줄임 import | `import numpy as np` 허용 | 표준 약어만 허용 |
| 그룹 구분 | 빈 줄로 구분 | 빈 줄로 구분 |

### 표준 약어 (NumPy / PyTorch)

```python
# 표준 약어 — 전 세계적으로 통용
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torch.utils.data import DataLoader, Dataset
```

### 사칙연산 예제 import

```python
# 표준 라이브러리
import os
import sys
from pathlib import Path
from typing import Optional, Tuple

# 서드파티
import numpy as np
import torch
import torch.nn as nn

# 로컬
from arithmetic.plus import Plus
from arithmetic.minus import Minus
```

---

## 10. 들여쓰기 및 포맷

| 항목 | PEP8 | Google Style |
|---|---|---|
| 들여쓰기 | **4 spaces** | **4 spaces** |
| 최대 줄 길이 | **79자** | **80자** (사실상 동일) |
| 문자열 따옴표 | 단일 또는 이중 (일관성 유지) | 이중 따옴표 권장 |
| 빈 줄 | 함수/클래스 사이 2줄 | 함수/클래스 사이 2줄 |

---

## 11. docstring 관례

Python 에서 docstring 은 세 가지 스타일이 있습니다.

| 스타일 | 사용처 |
|---|---|
| Google Style | Google 프로젝트, PyTorch, 일반 프로젝트 |
| NumPy Style | NumPy, SciPy, 수치해석 프로젝트 |
| reStructuredText | Sphinx 문서 자동화 |

### Google Style Docstring

```python
def division(x: int, y: int) -> float:
    """두 수를 나눈다.

    Args:
        x: 피제수.
        y: 제수. 0 이면 ValueError 발생.

    Returns:
        x / y 의 실수 결과.

    Raises:
        ValueError: y 가 0 인 경우.

    Example:
        >>> division(4, 2)
        2.0
    """
    if y == 0:
        raise ValueError("Division by zero")
    return x / y
```

### NumPy Style Docstring

```python
def division(x: int, y: int) -> float:
    """두 수를 나눈다.

    Parameters
    ----------
    x : int
        피제수.
    y : int
        제수. 0 이면 ValueError 발생.

    Returns
    -------
    float
        x / y 의 실수 결과.

    Raises
    ------
    ValueError
        y 가 0 인 경우.

    Examples
    --------
    >>> division(4, 2)
    2.0
    """
    if y == 0:
        raise ValueError("Division by zero")
    return x / y
```

NumPy / SciPy 기반 수치해석 프로젝트에서는 **NumPy Style** 을 권장합니다.
PyTorch 프로젝트에서는 **Google Style** 을 많이 사용합니다.

---

## 12. 테스트 파일명 및 테스트 함수명

| 항목 | PEP8 / Google Style |
|---|---|
| 테스트 파일명 | `test_모듈명.py` |
| 테스트 클래스명 | `Test클래스명` (PascalCase, Test 접두사) |
| 테스트 함수명 | `test_메서드명_시나리오` (snake_case, test_ 접두사) |

### C++ / Java 와의 차이

| 항목 | Python | C++ Google | Java Google |
|---|---|---|---|
| 테스트 파일명 | `test_plus.py` | `plus_test.cc` | `PlusTest.java` |
| 테스트 클래스명 | `TestPlus` | `PlusTest` | `PlusTest` |
| 테스트 함수명 | `test_addition_basic` | `Addition_Basic` | `addition_basic()` |

---

## 13. 테스트 전체 코드 — 사칙연산 예제

### pytest 방식 (권장)

```python
# tests/test_arithmetic_operations.py
import pytest
from arithmetic.arithmetic_operations import ArithmeticOperations


class TestArithmeticOperations:
    """ArithmeticOperations 클래스 테스트."""

    def setup_method(self):
        """각 테스트 실행 전 초기화."""
        self.ao = ArithmeticOperations()

    # --- addition ---
    def test_addition_with_positive_numbers(self):
        assert self.ao.addition(4, 2) == 6

    def test_addition_with_negative_numbers(self):
        assert self.ao.addition(-1, -10) == -11

    def test_addition_with_zero(self):
        assert self.ao.addition(0, 0) == 0

    # --- subtraction ---
    def test_subtraction_basic(self):
        assert self.ao.subtraction(4, 2) == 2

    def test_subtraction_result_negative(self):
        assert self.ao.subtraction(2, 5) == -3

    # --- multiplication ---
    def test_multiplication_basic(self):
        assert self.ao.multiplication(4, 2) == 8

    def test_multiplication_with_negative(self):
        assert self.ao.multiplication(-5, -3) == 15

    def test_multiplication_with_zero(self):
        assert self.ao.multiplication(0, 10) == 0

    # --- division ---
    def test_division_basic(self):
        assert self.ao.division(4, 2) == 2

    def test_division_raises_when_zero(self):
        with pytest.raises(ValueError):
            self.ao.division(4, 0)

    # --- quotient ---
    def test_quotient_returns_float(self):
        assert self.ao.quotient(5, 2) == pytest.approx(2.5)

    def test_quotient_raises_when_zero(self):
        with pytest.raises(ValueError):
            self.ao.quotient(4, 0)
```

### pytest 실행 명령어

```bash
# 전체 테스트 실행
pytest

# 특정 파일 실행
pytest tests/test_arithmetic_operations.py

# 특정 클래스 실행
pytest tests/test_arithmetic_operations.py::TestArithmeticOperations

# 특정 함수 실행
pytest tests/test_arithmetic_operations.py::TestArithmeticOperations::test_addition_with_positive_numbers

# 상세 결과 출력
pytest -v

# 커버리지 측정
pytest --cov=arithmetic --cov-report=html
```

---

## 14. NumPy 코드 관례

```python
import numpy as np

# 배열 변수명 — snake_case, 의미 있는 이름
x_train = np.zeros((100, 28, 28), dtype=np.float32)
y_train = np.ones(100, dtype=np.int64)

# 행렬 연산 — 대문자 단독 변수 허용 (수학 관례)
A = np.array([[1, 2], [3, 4]])
B = np.array([[5, 6], [7, 8]])
C = A @ B  # 행렬 곱

# 함수명 — snake_case
def normalize_array(x: np.ndarray) -> np.ndarray:
    """배열을 정규화한다."""
    return (x - x.mean()) / (x.std() + 1e-8)

def compute_accuracy(y_pred: np.ndarray, y_true: np.ndarray) -> float:
    """분류 정확도를 계산한다."""
    return (y_pred == y_true).mean()

# 상수 — UPPER_SNAKE_CASE
NUM_CLASSES = 10
INPUT_SIZE = 784
HIDDEN_SIZE = 256
```

---

## 15. PyTorch 코드 관례

```python
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.utils.data import DataLoader

# 하이퍼파라미터 — UPPER_SNAKE_CASE 또는 snake_case
BATCH_SIZE = 32
LEARNING_RATE = 1e-3
NUM_EPOCHS = 100
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# 모델 클래스 — PascalCase
class SimpleClassifier(nn.Module):
    """단순 분류 모델."""

    def __init__(self, input_size: int, num_classes: int):
        super().__init__()
        self.fc1 = nn.Linear(input_size, 256)
        self.fc2 = nn.Linear(256, num_classes)
        self.dropout = nn.Dropout(p=0.5)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = F.relu(self.fc1(x))
        x = self.dropout(x)
        return self.fc2(x)


# 학습 함수 — snake_case
def train_one_epoch(
    model: nn.Module,
    dataloader: DataLoader,
    optimizer: torch.optim.Optimizer,
    criterion: nn.Module,
    device: torch.device,
) -> float:
    """한 에폭 학습을 수행한다."""
    model.train()
    total_loss = 0.0

    for batch_idx, (inputs, targets) in enumerate(dataloader):
        inputs = inputs.to(device)
        targets = targets.to(device)

        optimizer.zero_grad()
        outputs = model(inputs)
        loss = criterion(outputs, targets)
        loss.backward()
        optimizer.step()

        total_loss += loss.item()

    return total_loss / len(dataloader)


# 평가 함수 — snake_case
def evaluate(
    model: nn.Module,
    dataloader: DataLoader,
    device: torch.device,
) -> float:
    """모델을 평가한다."""
    model.eval()
    correct = 0
    total = 0

    with torch.no_grad():
        for inputs, targets in dataloader:
            inputs = inputs.to(device)
            targets = targets.to(device)
            outputs = model(inputs)
            _, predicted = outputs.max(1)
            correct += predicted.eq(targets).sum().item()
            total += targets.size(0)

    return correct / total
```

---

## 16. 전체 비교 요약표

| 항목 | PEP8 | Google Style | NumPy 관례 | PyTorch 관례 |
|---|---|---|---|---|
| **루트 폴더명** | `snake_case` | `snake_case` | `snake_case` | `snake_case` |
| **파일명** | `snake_case.py` | `snake_case.py` | `snake_case.py` | `snake_case.py` |
| **테스트 파일명** | `test_모듈명.py` | `test_모듈명.py` | `test_모듈명.py` | `test_모듈명.py` |
| **클래스명** | `PascalCase` | `PascalCase` | `PascalCase` | `PascalCase` |
| **함수/메서드명** | `snake_case` | `snake_case` | `snake_case` | `snake_case` |
| **변수명** | `snake_case` | `snake_case` | `snake_case` | `snake_case` |
| **행렬/텐서 변수** | `snake_case` | `snake_case` | 대문자 단독 허용 (`A`, `B`) | `snake_case` |
| **상수** | `UPPER_SNAKE_CASE` | `UPPER_SNAKE_CASE` | `UPPER_SNAKE_CASE` | `UPPER_SNAKE_CASE` |
| **내부 변수** | `_snake_case` | `_snake_case` | `_snake_case` | `_snake_case` |
| **들여쓰기** | **4 spaces** | **4 spaces** | 4 spaces | 4 spaces |
| **최대 줄 길이** | **79자** | **80자** | 79자 | 79~88자 |
| **docstring** | 자유 | Google Style | **NumPy Style** | Google Style |
| **테스트 클래스명** | `TestXxx` | `TestXxx` | `TestXxx` | `TestXxx` |
| **테스트 함수명** | `test_메서드_시나리오` | `test_메서드_시나리오` | `test_메서드_시나리오` | `test_메서드_시나리오` |
| **테스트 프레임워크** | pytest / unittest | pytest | pytest | pytest |

---

## 17. 핵심 차이 한 줄 요약

```
폴더명       : Python = snake_case       / C++ Google = snake_case / C++ MS = PascalCase
파일명       : Python = snake_case.py    / C++ Google = snake_case.cc / C++ MS = PascalCase.cpp
클래스명     : Python = PascalCase       / C++ = PascalCase     / Java = PascalCase (모두 동일)
함수/메서드명 : Python = snake_case()     / C++ = PascalCase()   / Java = camelCase()
변수명       : Python = snake_case       / C++ Google = snake_case_ / Java = camelCase
상수         : Python = UPPER_SNAKE_CASE / C++ Google = kPascalCase / Java = UPPER_SNAKE_CASE
테스트 파일명 : Python = test_plus.py    / C++ Google = plus_test.cc / Java = PlusTest.java
테스트 클래스 : Python = TestPlus        / C++ Google = PlusTest    / Java = PlusTest
테스트 함수명 : Python = test_addition_basic  / C++ = Addition_Basic / Java = addition_basic
```

---

## 18. 코드 포맷터 및 린터

Python 에서는 포맷터를 사용해 스타일을 자동으로 통일할 수 있습니다.

| 도구 | 역할 | 권장 사용처 |
|---|---|---|
| `black` | 코드 자동 포맷 (강제) | 모든 프로젝트 |
| `ruff` | 빠른 린터 + 포맷터 | 최신 프로젝트 |
| `flake8` | PEP8 준수 검사 | CI/CD |
| `pylint` | 정적 분석 | 대규모 프로젝트 |
| `mypy` | 타입 힌팅 검사 | 타입 안전성 필요 시 |
| `isort` | import 순서 자동 정렬 | 모든 프로젝트 |

```bash
# 설치
pip install black ruff flake8 mypy isort

# 포맷 적용
black .
isort .

# 검사
ruff check .
flake8 .
mypy .
```
