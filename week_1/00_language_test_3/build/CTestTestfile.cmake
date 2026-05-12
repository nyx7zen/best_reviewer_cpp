# CMake generated Testfile for 
# Source directory: D:/edu_2026/best_reviewer_cpp/week_1/00_language_test_3
# Build directory: D:/edu_2026/best_reviewer_cpp/week_1/00_language_test_3/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(TestPlus "D:/edu_2026/best_reviewer_cpp/week_1/00_language_test_3/build/TestPlus.exe")
set_tests_properties(TestPlus PROPERTIES  _BACKTRACE_TRIPLES "D:/edu_2026/best_reviewer_cpp/week_1/00_language_test_3/CMakeLists.txt;53;add_test;D:/edu_2026/best_reviewer_cpp/week_1/00_language_test_3/CMakeLists.txt;0;")
add_test(TestMinus "D:/edu_2026/best_reviewer_cpp/week_1/00_language_test_3/build/TestMinus.exe")
set_tests_properties(TestMinus PROPERTIES  _BACKTRACE_TRIPLES "D:/edu_2026/best_reviewer_cpp/week_1/00_language_test_3/CMakeLists.txt;54;add_test;D:/edu_2026/best_reviewer_cpp/week_1/00_language_test_3/CMakeLists.txt;0;")
subdirs("external/googletest-1.16.0")
