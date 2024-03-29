[:ru: Оригинал](README.md)

CMake-based template for C++ project
====================================

Clone, replace "Mylib" with the desired name, and it's done.

Or generate a new project with a script: https://github.com/izvolov/mylib-gen/blob/master/README.en.md

Contents
--------

1.  [Build](#build)
    1.  [Generate a build system](#generate-a-build-system)
    2.  [Build a project](#build-a-project)
2.  [Options](#options)
    1.  [MYLIB_COVERAGE](#MYLIB_COVERAGE)
    2.  [MYLIB_TESTING](#MYLIB_TESTING)
    3.  [DOXYGEN_OUTPUT_LANGUAGE](#DOXYGEN_OUTPUT_LANGUAGE)
3.  [Targets](#targets)
    1.  [Default](#default)
    2.  [mylib_library](#mylib_library)
    3.  [mylib-unit-tests](#mylib-unit-tests)
    4.  [check](#check)
    5.  [coverage](#coverage)
    6.  [doc](#doc)
    7.  [wandbox](#wandbox)
4.  [Examples](#examples)
5.  [Usage](#usage)
    1.  [Through the installation](#through-the-installation)
    2.  [As a submodule](#as-a-submodule)
6.  [Tools](#tools)
7.  [Bonus](#bonus)

Build
-----

Building this project, like any other CMake project, consists of two stages:

### Generate a build system

```shell
cmake -S path/to/sources -B path/to/build/directory [options ...]
```

[More about options](#options).

### Build a project

```shell
cmake --build path/to/build/directory [--target target]
```

[More about targets](#targets).

Options
-------

### MYLIB_COVERAGE

```shell
cmake -S ... -B ... -DMYLIB_COVERAGE=ON [other options ...]
```

Turns on the [`coverage`](#coverage) target which performs code coverage measurement.

### MYLIB_TESTING

```shell
cmake -S ... -B ... -DMYLIB_TESTING=OFF [other options ...]
```

Provides the ability to turn off unit testing and hence the [`check`](#check) target. As a result, the code coverage measurement is also turned off (see [Code coverage](#MYLIB_COVERAGE)).

Also, testing is automatically disabled if the project is included to another project as a subproject using the [`add_subdirectory`](https://cmake.org/cmake/help/v3.14/command/add_subdirectory.html) command.

### DOXYGEN_OUTPUT_LANGUAGE

```shell
cmake -S ... -B ... -DDOXYGEN_OUTPUT_LANGUAGE=English [other options ...]
```

Switches the language of the documentation generated by the [`doc`](#doc) target. For a list of available languages, see [Doxygen site](http://www.doxygen.nl/manual/config.html#cfg_output_language).

Default language is Russian.

Targets
-------

### Default

```shell
cmake --build path/to/build/directory
cmake --build path/to/build/directory --target all
```

If a target is not specified (which is equivalent to the `all` target), it builds everything possible including unit tests and also calls the [`check`](#check) target.

### mylib_library

```shell
cmake --build path/to/build/directory --target mylib_library
```

Compiles the `mylib_library` library. Enabled by default.

### mylib-unit-tests

```shell
cmake --build path/to/build/directory --target mylib-unit-tests
```

Builds unit tests. Enabled by default.

### check

```shell
cmake --build path/to/build/directory --target check
```

Launches built (and builds if not yet) unit tests. Enabled by default.

See also [`mylib-unit-tests`](#mylib-unit-tests).

### coverage

```shell
cmake --build path/to/build/directory --target coverage
```

Analyzes run unit tests (and runs is not yet) using [gcovr](https://gcovr.com).

Target is only available if [`MYLIB_COVERAGE`](#MYLIB_COVERAGE) option is on.

See also [`check`](#check).

### doc

```shell
cmake --build path/to/build/directory --target doc
```

Generates source code documentation using [Doxygen](http://doxygen.nl).

### wandbox

```shell
cmake --build path/to/build/directory --target wandbox
```

The [Wandbox](https://wandbox.org) service is used. Please, don't abuse it.

Examples
--------

#### Building the project in the debug mode and measure a coverage

```shell
cmake -S path/to/sources -B path/to/build/directory -DCMAKE_BUILD_TYPE=Debug -DMYLIB_COVERAGE=ON
cmake --build path/to/build/directory --target coverage --parallel 16
```

#### Installing the project without building and testing it

```shell
cmake -S path/to/sources -B path/to/build/directory -DMYLIB_TESTING=OFF -DCMAKE_INSTALL_PREFIX=path/to/install/directory
cmake --build path/to/build/directory --target install
```

#### Building the project in the release mode with a specified compiler

```shell
cmake -S path/to/sources -B path/to/build/directory -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++-8 -DCMAKE_PREFIX_PATH=path/to/installed/dependencies
cmake --build path/to/build/directory --parallel 4
```

#### Generating the documentation in English

```shell
cmake -S path/to/sources -B path/to/build/directory -DCMAKE_BUILD_TYPE=Release -DDOXYGEN_OUTPUT_LANGUAGE=English
cmake --build path/to/build/directory --target doc
```

Usage
-----

### Through the installation

One of the ways to use the module is to install it into the system.

```shell
cmake --build path/to/build/directory --target install
```

After that, all the libraries from the `Mylib::` namespace can be used from any other project using the [`find_package`](https://cmake.org/cmake/help/v3.14/command/find_package.html) command:

```cmake
find_package(Mylib 1.0 REQUIRED)

add_executable(some_executable some.cpp sources.cpp)
target_link_libraries(some_executable PRIVATE Mylib::library)
```

`Mylib::headers` library is used for the headers only, and `Mylib::library` library is used when it is also needed to link with the `libmylib_library` library.

### As a submodule

The project can also be used by another project as a submodule using the [`add_subdirectory`](https://cmake.org/cmake/help/v3.14/command/add_subdirectory.html) command:

In this case, libraries `Mylib::library` and `Mylib::headers` will be available in the same manner.

Tools
-----

1.  [CMake](https://cmake.org) 3.14

    CMake 3.14 is required because of incorrect work of the command `install(TARGETS ... EXPORT ...)`: is does not set default install paths properly.

2.  [doctest](https://github.com/onqtam/doctest) testing framework

    Testing might be turned off (see [Testing](#MYLIB_TESTING)).

3.  [Doxygen](http://doxygen.nl)

    Switching the language of the generated documentation is provided by the [`DOXYGEN_OUTPUT_LANGUAGE`](#DOXYGEN_OUTPUT_LANGUAGE) option.

4.  [Python 3](https://www.python.org) interpreter

    Used to generate an [online sandbox](#wandbox).

Bonus
-----

With CMake and a couple of good tools, you can get a static analysis with minimal effort.

### Cppcheck

CMake has build-in support for [Cppcheck](http://cppcheck.sourceforge.net).

It is provided by the [`CMAKE_CXX_CPPCHECK`](https://cmake.org/cmake/help/v3.14/variable/CMAKE_LANG_CPPCHECK.html#variable:CMAKE_<LANG>_CPPCHECK) option:

```shell
cmake -S path/to/sources -B path/to/build/directory -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_CPPCHECK="cppcheck;--enable=all;-Ipath/to/sources/include"
```

After that, static analysis will be automatically run every time the source code is compiled and recompiled.

### Clang

With [`scan-build`](https://clang-analyzer.llvm.org/scan-build) you can run static analysis easily, too:

```shell
scan-build cmake -S path/to/sources -B path/to/build/directory -DCMAKE_BUILD_TYPE=Debug
scan-build cmake --build path/to/build/directory
```

Here, unlike the case of [Cppcheck](#cppcheck) it is required to build the project using `scan-build` each time.
