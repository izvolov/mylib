set(WANDBOX_URL "https://wandbox.org/api/compile.json")

find_program(PYTHON3_EXECUTABLE python3)
if(PYTHON3_EXECUTABLE)
    add_custom_target(wandbox
        COMMAND
            ${PYTHON3_EXECUTABLE} "${CMAKE_CURRENT_SOURCE_DIR}/generate-wandbox.py"
                "${CMAKE_CURRENT_SOURCE_DIR}/mylib-example.cpp"
                "${PROJECT_SOURCE_DIR}"
                include |
            curl -H "Content-type: application/json" -d @- ${WANDBOX_URL}
        DEPENDS
            mylib-unit-tests
    )
else()
    message(WARNING "Для создания онлайн-песочницы требуется интерпретатор ЯП python 3-й версии")
endif()
