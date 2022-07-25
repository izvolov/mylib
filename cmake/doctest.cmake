set(MYLIB_DOCTEST_VERSION 2.3.4)
set(MYLIB_DOCTEST_REPOSITORY https://github.com/doctest/doctest.git)

find_package(doctest ${MYLIB_DOCTEST_VERSION})

if (doctest_FOUND)
    message(STATUS "Найден doctest ${doctest_VERSION}: ${doctest_DIR}")
else()
    message(STATUS
        "doctest ${MYLIB_DOCTEST_VERSION} будет взят с гитхаба: ${MYLIB_DOCTEST_REPOSITORY}")

    include(FetchContent)
    FetchContent_Declare(doctest
        GIT_REPOSITORY
            ${MYLIB_DOCTEST_REPOSITORY}
        GIT_TAG
            ${MYLIB_DOCTEST_VERSION}
    )
    FetchContent_MakeAvailable(doctest)
endif()
