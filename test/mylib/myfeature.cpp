#include <mylib/myfeature.hpp>

#include <doctest/doctest.h>

TEST_CASE("Функция myfunc делает классные штуки со структурой mystruct")
{
    CHECK(mylib::myfunc(mylib::mystruct{}));
}
