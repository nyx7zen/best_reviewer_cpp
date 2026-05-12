#include "test.h"
#include <iostream>

void Test::run() {
    int a = 1;
    int b = 2;
    int c = a + b;

    std::cout<< "Call run" << std::endl;
    std::cout<< c << std::endl;
}