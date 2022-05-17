add_executable(mylib-example mylib_example.cpp)
target_link_libraries(mylib-example
    PRIVATE
        Mylib::library
)

add_custom_target(run-mylib-example ALL COMMAND mylib-example)

find_package(Python3 COMPONENTS Interpreter)
if(Python3_FOUND)
    set(WANDBOX_URL "https://wandbox.org/api/compile.json")

    add_custom_target(wandbox
        COMMAND
            Python3::Interpreter wandbox.py mylib_example.cpp "${PROJECT_SOURCE_DIR}" include |
            curl -H "Content-type: application/json" -d @- ${WANDBOX_URL}
        WORKING_DIRECTORY
            ${CMAKE_CURRENT_SOURCE_DIR}
        DEPENDS
            mylib-unit-tests
    )
else()
    message(WARNING "Для создания онлайн-песочницы требуется интерпретатор ЯП python 3-й версии")
endif()
