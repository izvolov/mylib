file(GLOB_RECURSE MYLIB_HEADERS
    RELATIVE
        ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/include/*.hpp
)

configure_file(mylib-example.py.in mylib-example.py @ONLY)

set(WANDBOX_URL "https://wandbox.org/api/compile.json")
add_custom_target(wandbox
    COMMAND
        python mylib-example.py | curl -H "Content-type: application/json" -d @- ${WANDBOX_URL}
    DEPENDS
        mylib-unit-tests
)
