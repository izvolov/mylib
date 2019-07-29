find_program(PYTHON3_EXECUTABLE python3)
if(PYTHON3_EXECUTABLE)
    set(WANDBOX_URL "https://wandbox.org/api/compile.json")

    add_custom_target(wandbox
        COMMAND
            ${PYTHON3_EXECUTABLE} wandbox.py mylib_example.cpp "${PROJECT_SOURCE_DIR}" include |
            curl -H "Content-type: application/json" -d @- ${WANDBOX_URL}
        WORKING_DIRECTORY
            ${CMAKE_CURRENT_SOURCE_DIR}
        DEPENDS
            mylib-unit-tests
    )
else()
    message(WARNING "Для создания онлайн-песочницы требуется интерпретатор ЯП python 3-й версии")
endif()
