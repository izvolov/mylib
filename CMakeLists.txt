###################################################################################################
##
##      Информация о проекте
##
###################################################################################################

cmake_minimum_required(VERSION 3.12)
project(Mylib VERSION 1.0 LANGUAGES CXX)

get_directory_property(IS_SUBPROJECT PARENT_DIRECTORY)

###################################################################################################
##
##      Опции проекта
##
###################################################################################################

option(MYLIB_TESTING "Включить модульное тестирование" ON)
option(MYLIB_COVERAGE "Включить измерение покрытия кода тестами" OFF)

###################################################################################################
##
##      Опции компиляции
##
###################################################################################################

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

if(NOT CMAKE_CXX_EXTENSIONS)
    set(CMAKE_CXX_EXTENSIONS OFF)
endif()

###################################################################################################
##
##      Основная цель
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
##      Установка
##
###################################################################################################

install(DIRECTORY include/mylib DESTINATION include)

install(TARGETS mylib EXPORT MylibConfig)
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
elseif(IS_SUBPROJECT)
    message(STATUS "Mylib не тестируется в режиме подмодуля")
else()
    add_subdirectory(test)
endif()

###################################################################################################
##
##      Документация
##
###################################################################################################

if(NOT IS_SUBPROJECT)
    add_subdirectory(doc)
endif()

###################################################################################################
##
##      Онлайн-песочница
##
###################################################################################################

if(NOT IS_SUBPROJECT)
    add_subdirectory(online)
endif()
