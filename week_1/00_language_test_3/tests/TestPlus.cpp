#include "gtest/gtest.h"
#include "../src/Plus.h"

TEST(TestPlus, Addition_Basic) {
    EXPECT_EQ(3, Plus::run(1, 2));
}

TEST(TestPlus, Addition_Negative) {
    EXPECT_EQ(-3, Plus::run(-1, -2));
}

TEST(TestPlus, Addition_Zero) {
    EXPECT_EQ(0, Plus::run(0, 0));
}