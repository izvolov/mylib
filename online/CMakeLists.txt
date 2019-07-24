set(WANDBOX_URL "https://wandbox.org/api/compile.json")

add_custom_target(wandbox
    COMMAND
        python3 "${CMAKE_CURRENT_SOURCE_DIR}/generate-wandbox.py"
            "${CMAKE_CURRENT_SOURCE_DIR}/mylib-example.cpp"
            "${PROJECT_SOURCE_DIR}"
            include |
        curl -H "Content-type: application/json" -d @- ${WANDBOX_URL}
    DEPENDS
        mylib-unit-tests
)
