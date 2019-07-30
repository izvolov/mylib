[:uk: English version](README.en.md)

Шаблон проекта на основе системы сборки CMake для языка C++
===========================================================

Скопировать, поменять "Mylib" на нужное название — и в путь.

[![Статус сборки](https://travis-ci.org/izvolov/mylib.svg?branch=master)](https://travis-ci.org/izvolov/mylib) [![Статус покрытия](https://coveralls.io/repos/github/izvolov/mylib/badge.svg?branch=master)](https://coveralls.io/github/izvolov/mylib?branch=master) [![Попробовать онлайн на Wandbox.org](https://img.shields.io/badge/try-online-blue.svg)](https://wandbox.org/permlink/QElvxuMzHgL9fqci)


Содержание
----------

1.  [Сборка](#сборка)
    1.  [Генерация](#генерация)
    2.  [Сборка](#сборка-проекта)
2.  [Опции](#опции)
    1.  [MYLIB_COVERAGE](#MYLIB_COVERAGE)
    2.  [MYLIB_TESTING](#MYLIB_TESTING)
    3.  [MYLIB_DOXYGEN_LANGUAGE](#MYLIB_DOXYGEN_LANGUAGE)
3.  [Сборочные цели](#сборочные-цели)
    1.  [По умолчанию](#по-умолчанию)
    2.  [mylib-unit-tests](#mylib-unit-tests)
    3.  [check](#check)
    4.  [coverage](#coverage)
    5.  [doc](#doc)
    6.  [wandbox](#wandbox)
4.  [Примеры](#примеры)
5.  [Инструменты](#инструменты)
6.  [Бонус](#бонус)

Сборка
------

Сборка данного проекта, как и любого другого проекта на системе сборки CMake, состоит из двух этапов:

### Генерация

```shell
cmake -S путь/к/исходникам -B путь/к/сборочной/директории [опции ...]
```

[Подробнее про опции](#опции).

### Сборка проекта

```shell
cmake --build путь/к/сборочной/директории [--target target]
```

[Подробнее про сборочные цели](#сборочные-цели).

Опции
-----

### MYLIB_COVERAGE

```shell
cmake -S ... -B ... -DMYLIB_COVERAGE=ON [прочие опции ...]
```

Включает цель [`coverage`](#coverage), с помощью которой можно запустить замер покрытия кода тестами.

### MYLIB_TESTING

```shell
cmake -S ... -B ... -DMYLIB_TESTING=OFF [прочие опции ...]
```

Предоставляет возможность выключить сборку модульных тестов и цель [`check`](#check). Как следствие, выключается замер покрытия кода тестами (см. [Покрытие](#MYLIB_COVERAGE)).

Также тестирование автоматически отключается в случае, если проект подключается в другой проект качестве подпроекта с помощью команды [`add_subdirectory`](https://cmake.org/cmake/help/v3.8/command/add_subdirectory.html).

### MYLIB_DOXYGEN_LANGUAGE

```shell
cmake -S ... -B ... -DMYLIB_DOXYGEN_LANGUAGE=English [прочие опции ...]
```

Переключает язык документации, которую генерирует цель [`doc`](#doc) на заданный. Список доступных языков см. на [сайте системы Doxygen](http://www.doxygen.nl/manual/config.html#cfg_output_language).

По умолчанию включён русский.

Сборочные цели
--------------

### По умолчанию

```shell
cmake --build path/to/build/directory
cmake --build path/to/build/directory --target all
```

Если цель не указана (что эквивалентно цели `all`), собирает всё, что можно, а также вызывает цель [`check`](#check).

### mylib-unit-tests

```shell
cmake --build path/to/build/directory --target mylib-unit-tests
```

Компилирует модульные тесты. Включено по умолчанию.

### check

```shell
cmake --build путь/к/сборочной/директории --target check
```

Запускает собранные (собирает, если ещё не) модульные тесты. Включено по умолчанию.

См. также [`mylib-unit-tests`](#mylib-unit-tests).

### coverage

```shell
cmake --build путь/к/сборочной/директории --target coverage
```

Анализирует запущенные (запускает, если ещё не) модульные тесты на предмет покрытия кода тестами при помощи программы [gcovr](https://gcovr.com).

Цель доступна только при включённой опции [`MYLIB_COVERAGE`](#MYLIB_COVERAGE).

См. также [`check`](#check).

### doc

```shell
cmake --build путь/к/сборочной/директории --target doc
```

Запускает генерацию документации к коду при помощи системы [Doxygen](http://doxygen.nl).

### wandbox

```shell
cmake --build путь/к/сборочной/директории --target wandbox
```

Для этого используется сервис [Wandbox](https://wandbox.org). Не злоупотребляйте этой штукой, сервера не резиновые.

Примеры
-------

#### Сборка проекта в отладочном режиме с замером покрытия

```shell
cmake -S путь/к/исходникам -B путь/к/сборочной/директории -DCMAKE_BUILD_TYPE=Debug -DMYLIB_COVERAGE=ON
cmake --build путь/к/сборочной/директории --target coverage --parallel 16
```

#### Установка проекта без предварительной сборки и тестирования

```shell
cmake -S путь/к/исходникам -B путь/к/сборочной/директории -DMYLIB_TESTING=OFF -DCMAKE_INSTALL_PREFIX=путь/к/установойной/директории
cmake --build путь/к/сборочной/директории --target install
```

#### Сборка в выпускном режиме заданным компилятором

```shell
cmake -S путь/к/исходникам -B путь/к/сборочной/директории -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++-8 -DCMAKE_PREFIX_PATH=путь/к/директории/куда/установлены/зависимости
cmake --build путь/к/сборочной/директории --parallel 4
```

#### Генерирование документации на английском

```shell
cmake -S путь/к/исходникам -B путь/к/сборочной/директории -DCMAKE_BUILD_TYPE=Release -DMYLIB_DOXYGEN_LANGUAGE=English
cmake --build путь/к/сборочной/директории --target doc
```

Инструменты
-----------

1.  [CMake](https://cmake.org) 3.13

    На самом деле версия CMake 3.13 требуется только для запуска некоторых консольных команд, описанных в данной справке. С точки зрения синтаксиса CMake-скриптов достаточно версии 3.8, если генерацию вызывать другими способами.

2.  Библиотека тестирования [doctest](https://github.com/onqtam/doctest)

    Тестирование можно отключать (см. [Тестирование](#MYLIB_TESTING)).

3.  [Doxygen](http://doxygen.nl)

    Для переключения языка, на котором будет сгенерирована документация, предусмотрена опция [`MYLIB_DOXYGEN_LANGUAGE`](#MYLIB_DOXYGEN_LANGUAGE).

4.  Интерпретатор ЯП [Python 3](https://www.python.org)

    Для автоматической генерации [онлайн-песочницы](#wandbox).

Бонус
-----

С помощью CMake и пары хороших инструментов можно обеспечить статический анализ с минимальными телодвижениями.

### Cppcheck

В CMake встроена поддержка инструмента для статического анализа [Cppcheck](http://cppcheck.sourceforge.net).

Для этого нужно воспользоваться опцией [`CMAKE_CXX_CPPCHECK`](https://cmake.org/cmake/help/v3.10/variable/CMAKE_LANG_CPPCHECK.html#variable:CMAKE_<LANG>_CPPCHECK):

```shell
cmake -S путь/к/исходникам -B путь/к/сборочной/директории -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_CPPCHECK="cppcheck;--enable=all;-Iпуть/к/исходникам/include"
```

После этого статический анализ будет автоматически запускаться каждый раз во время компиляции и перекомпиляции исходников. Ничего дополнительного делать не нужно.

### Clang

При помощи чудесного инструмента [`scan-build`](https://clang-analyzer.llvm.org/scan-build) тоже можно запускать статический анализ в два счёта:

```shell
scan-build cmake -S путь/к/исходникам -B путь/к/сборочной/директории -DCMAKE_BUILD_TYPE=Debug
scan-build cmake --build путь/к/сборочной/директории
```

Здесь, в отличие от случая с [Cppcheck](#cppcheck), требуется каждый раз запускать сборку через `scan-build`.
