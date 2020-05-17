###################################################################################################
##
##      Головной CMake
##
###################################################################################################

configure_file(CMakeLists.txt.in ${NEW_PROJECT_DIRECTORY}/CMakeLists.txt @ONLY)

###################################################################################################
##
##      Справка
##
###################################################################################################

configure_file(README.md.in ${NEW_PROJECT_DIRECTORY}/README.md @ONLY)
configure_file(README.en.md.in ${NEW_PROJECT_DIRECTORY}/README.en.md @ONLY)

###################################################################################################
##
##      Заголовки
##
###################################################################################################

configure_file(include/library/header.hpp.in ${NEW_PROJECT_DIRECTORY}/include/${NEW_PROJECT_NAME_LOWER}/header.hpp @ONLY)

###################################################################################################
##
##      Исходники
##
###################################################################################################

configure_file(src/library/source.cpp.in ${NEW_PROJECT_DIRECTORY}/src/${NEW_PROJECT_NAME_LOWER}/source.cpp @ONLY)

###################################################################################################
##
##      Тесты
##
###################################################################################################

configure_file(test/CMakeLists.txt.in ${NEW_PROJECT_DIRECTORY}/test/CMakeLists.txt @ONLY)
configure_file(test/test_main.cpp.in ${NEW_PROJECT_DIRECTORY}/test/test_main.cpp COPYONLY)
configure_file(test/library/test.cpp.in ${NEW_PROJECT_DIRECTORY}/test/${NEW_PROJECT_NAME_LOWER}/test.cpp @ONLY)

###################################################################################################
##
##      CI/CD
##
###################################################################################################

configure_file(.travis.yml.in ${NEW_PROJECT_DIRECTORY}/.travis.yml @ONLY)
configure_file(.appveyor.yml.in ${NEW_PROJECT_DIRECTORY}/.appveyor.yml @ONLY)

###################################################################################################
##
##      Лицензия
##
###################################################################################################

configure_file(LICENSE.md.in ${NEW_PROJECT_DIRECTORY}/LICENSE.md COPYONLY)

###################################################################################################
##
##      Документация
##
###################################################################################################

configure_file(doc/CMakeLists.txt.in ${NEW_PROJECT_DIRECTORY}/doc/CMakeLists.txt @ONLY)
configure_file(doc/Doxyfile.in.in ${NEW_PROJECT_DIRECTORY}/doc/Doxyfile.in @ONLY)

###################################################################################################
##
##      Песочница
##
###################################################################################################

configure_file(online/CMakeLists.txt.in ${NEW_PROJECT_DIRECTORY}/online/CMakeLists.txt @ONLY)
configure_file(online/library_example.cpp.in ${NEW_PROJECT_DIRECTORY}/online/${NEW_PROJECT_NAME_LOWER}_example.cpp @ONLY)
configure_file(online/wandbox.py.in ${NEW_PROJECT_DIRECTORY}/online/wandbox.py COPYONLY)
