###################################################################################################
##
##      Информация о проекте
##
###################################################################################################

cmake_minimum_required(VERSION 3.14)
project(LibGen VERSION 1.0 LANGUAGES CXX)

###################################################################################################
##
##      Опции
##
###################################################################################################

if (NOT NEW_PROJECT_NAME)
    message(WARNING
        "Название проекта не выбрано, будет использовано название \"Mylib\"."
        "Чтобы установить название проекта, воспользуйтесь опцией NEW_PROJECT_NAME:\n"
        "\tcmake -DNEW_PROJECT_NAME=<name> ..."
    )
    set(NEW_PROJECT_NAME Mylib)
endif()

string(TOLOWER ${NEW_PROJECT_NAME} NEW_PROJECT_NAME_LOWER)
string(TOUPPER ${NEW_PROJECT_NAME} NEW_PROJECT_NAME_UPPER)

message(STATUS "Название проекта: ${NEW_PROJECT_NAME}")
message(STATUS "Название проекта в нижнем регистре: ${NEW_PROJECT_NAME_LOWER}")
message(STATUS "Название проекта в верхнем регистре: ${NEW_PROJECT_NAME_UPPER}")

if (NOT OUTPUT_ROOT)
    message(WARNING
        "Не выбрана директория, в которую будут установлен сгенерированный проект."
        "Проект будет положен в текущую сборочную директорию."
        "Чтобы установить директорию, воспользуйтесь опцией OUTPUT_ROOT:\n"
        "\tcmake -DOUTPUT_ROOT=<directory> ..."
    )
    set(OUTPUT_ROOT ${CMAKE_CURRENT_BINARY_DIR}/${NEW_PROJECT_NAME_LOWER})
endif()

###################################################################################################
##
##      Генерация
##
###################################################################################################

set(NEW_PROJECT_DIRECTORY ${OUTPUT_ROOT}/${NEW_PROJECT_NAME_LOWER})

message(STATUS "Файлы проекта будут записаны в директорию ${NEW_PROJECT_DIRECTORY}")

add_subdirectory(templates)

###################################################################################################
##
##      Сборка проекта
##
###################################################################################################

add_subdirectory(${NEW_PROJECT_DIRECTORY} build)
