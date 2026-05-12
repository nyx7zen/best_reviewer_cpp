cmake_minimum_required(VERSION 3.14)

project(test_cmake LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 소스 라이브러리
set(SrcLib SrcLib)
set(SrcFiles
    src/Plus.cpp
    src/Minus.cpp
)
add_library(${SrcLib} STATIC ${SrcFiles})
target_include_directories(${SrcLib} PUBLIC src)

# GoogleTest — FetchContent 방식 (자동 다운로드)
add_subdirectory(external/googletest-1.16.0)

# include(FetchContent)
# FetchContent_Declare(
#     googletest
#     URL https://github.com/google/googletest/archive/refs/tags/v1.16.0.zip
#     TLS_VERIFY OFF
#     DOWNLOAD_EXTRACT_TIMESTAMP TRUE
# )
# set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
# FetchContent_MakeAvailable(googletest)

# TestPlus 실행파일
add_executable(TestPlus
    tests/TestPlus.cpp
)
target_link_libraries(TestPlus
    gtest_main
    ${SrcLib}
)
target_compile_options(TestPlus PRIVATE --coverage)
target_link_options(TestPlus PRIVATE --coverage)

# TestMinus 실행파일
add_executable(TestMinus
    tests/TestMinus.cpp
)
target_link_libraries(TestMinus
    gtest_main
    ${SrcLib}
)
target_compile_options(TestMinus PRIVATE --coverage)
target_link_options(TestMinus PRIVATE --coverage)

enable_testing()
add_test(NAME TestPlus COMMAND TestPlus)
add_test(NAME TestMinus COMMAND TestMinus)