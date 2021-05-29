###################################################################################################
##
##      Информация о проекте
##
###################################################################################################

cmake_minimum_required(VERSION 3.14)
project(Mylib VERSION 1.0 LANGUAGES CXX)

get_directory_property(IS_SUBPROJECT PARENT_DIRECTORY)

###################################################################################################
##
##      Опции проекта
##
###################################################################################################

if (IS_SUBPROJECT AND NOT DEFINED MYLIB_TESTING)
    message(STATUS "Mylib не тестируется в режиме подмодуля")
    set(MYLIB_TESTING OFF)
endif()

if (IS_SUBPROJECT AND NOT DEFINED MYLIB_DOC)
    message(STATUS "Автодокументация для Mylib выключена в режиме подмодуля")
    set(MYLIB_DOC OFF)
endif()

if (IS_SUBPROJECT AND NOT DEFINED MYLIB_WANDBOX)
    message(STATUS "Онлайн-песочница для Mylib выключена в режиме подмодуля")
    set(MYLIB_WANDBOX OFF)
endif()

option(MYLIB_TESTING "Включить модульное тестирование" ON)
option(MYLIB_COVERAGE "Включить измерение покрытия кода тестами" OFF)
option(MYLIB_DOC "Включить документирование" ON)
option(MYLIB_WANDBOX "Включить онлайн-песочницу" ON)

###################################################################################################
##
##      Опции компиляции
##
###################################################################################################

if((CMAKE_CXX_COMPILER_ID MATCHES "GNU") OR (CMAKE_CXX_COMPILER_ID MATCHES "Clang"))
    add_compile_options(
        -Werror

        -Wall
        -Wextra
        -Wpedantic

        -Wcast-align
        -Wcast-qual
        -Wconversion
        -Wctor-dtor-privacy
        -Wenum-compare
        -Wfloat-equal
        -Wnon-virtual-dtor
        -Wold-style-cast
        -Woverloaded-virtual
        -Wredundant-decls
        -Wsign-conversion
        -Wsign-promo
    )
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    add_compile_options(/W4 /WX)
endif()

if(NOT CMAKE_CXX_EXTENSIONS)
    set(CMAKE_CXX_EXTENSIONS OFF)
endif()

###################################################################################################
##
##      Заголовочная библиотека
##
###################################################################################################

add_library(mylib INTERFACE)
target_include_directories(mylib INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
target_compile_features(mylib INTERFACE cxx_std_17)

add_library(Mylib::mylib ALIAS mylib)

###################################################################################################
##
##      Компилируемая библиотека
##
###################################################################################################

add_library(myfeature src/mylib/source.cpp)
target_link_libraries(myfeature PUBLIC mylib)

add_library(Mylib::myfeature ALIAS myfeature)

###################################################################################################
##
##      Установка
##
###################################################################################################

install(DIRECTORY include/mylib DESTINATION include)

install(TARGETS mylib myfeature EXPORT MylibConfig)
install(EXPORT MylibConfig NAMESPACE Mylib:: DESTINATION share/Mylib/cmake)

include(CMakePackageConfigHelpers)
write_basic_package_version_file("${PROJECT_BINARY_DIR}/MylibConfigVersion.cmake"
    VERSION
        ${PROJECT_VERSION}
    COMPATIBILITY
        AnyNewerVersion
)
install(FILES "${PROJECT_BINARY_DIR}/MylibConfigVersion.cmake" DESTINATION share/Mylib/cmake)

###################################################################################################
##
##      Тесты
##
###################################################################################################

if(NOT MYLIB_TESTING)
    message(STATUS "Тестирование проекта Mylib выключено")
else()
    add_subdirectory(test)
endif()

###################################################################################################
##
##      Документация
##
###################################################################################################

if(NOT MYLIB_DOC)
    message(STATUS "Автодокументация проекта Mylib выключена")
else()
    add_subdirectory(doc)
endif()

###################################################################################################
##
##      Онлайн-песочница
##
###################################################################################################

if(NOT MYLIB_WANDBOX)
    message(STATUS "Онлайн-песочница для проекта Mylib выключена")
else()
    add_subdirectory(online)
endif()
