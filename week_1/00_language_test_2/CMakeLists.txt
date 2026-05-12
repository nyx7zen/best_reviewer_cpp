cmake_minimum_required(VERSION 3.10)

project(language_test VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(language_test
    src/main.cpp
    src/Test.cpp
)

target_include_directories(language_test PRIVATE src)