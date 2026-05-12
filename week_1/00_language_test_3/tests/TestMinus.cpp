#include "gtest/gtest.h"
#include "../src/minus.h"

TEST(TestMinus, Subtraction_Basic) {
    EXPECT_EQ(1, Minus::run(3, 2));
}

TEST(TestMinus, Subtraction_Negative) {
    EXPECT_EQ(-1, Minus::run(-3, -2));
}

TEST(TestMinus, Subtraction_Zero) {
    EXPECT_EQ(0, Minus::run(0, 0));
}