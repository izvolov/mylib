find_package(doctest 2.3.3 REQUIRED)

add_executable(mylib-unit-tests test_main.cpp)
target_sources(mylib-unit-tests PRIVATE mylib/test.cpp)
target_link_libraries(mylib-unit-tests
    PRIVATE
        Mylib::library
        doctest::doctest
)

find_program(GCOVR_EXECUTABLE gcovr)
if(MYLIB_COVERAGE AND GCOVR_EXECUTABLE)
    message(STATUS "Измерение покрытия кода тестами включено")

    target_compile_options(mylib-unit-tests PRIVATE --coverage)
    target_link_options(mylib-unit-tests PRIVATE -fprofile-arcs)

    target_compile_options(mylib_library PRIVATE --coverage)
    target_link_options(mylib_library PRIVATE -fprofile-arcs)

    add_custom_target(coverage
        COMMAND
            ${GCOVR_EXECUTABLE}
                --root=${PROJECT_SOURCE_DIR}/
                --filter=${PROJECT_SOURCE_DIR}/include
                --filter=${PROJECT_SOURCE_DIR}/src
                --object-directory=${PROJECT_BINARY_DIR}
        DEPENDS
            check
    )
elseif(MYLIB_COVERAGE AND NOT GCOVR_EXECUTABLE)
    set(MYLIB_COVERAGE OFF)
    message(WARNING "Для замеров покрытия кода тестами требуется программа gcovr")
endif()

add_custom_target(check ALL COMMAND mylib-unit-tests)
