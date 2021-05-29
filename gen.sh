#!/usr/bin/env bash

###################################################################################################
##
##  Скрипт позволяет генерировать проект с заданным именем
##
###################################################################################################

if [[ $# -lt 2 || $# -gt 4 ]]; then
    required="<path/to/new/library/directory> <LibraryName>"
    optional="<lowercase_library_name> <UPPERCASE_LIBRARY_NAME>"
    echo "Usage: $0 $required [$optional]"
    exit
fi

#--------------------------------------------------------------------------------------------------
#
#   Работа с именем нового проекта
#
#--------------------------------------------------------------------------------------------------

libname=$2

echo "Library name would be \"$libname\""

if [ -n "$3" ]; then
    libname_lowercase=$3
    echo "Lowercase library name would be \"$libname_lowercase\""
else
    libname_lowercase=$(echo "$libname" | tr "[:upper:]" "[:lower:]")
    echo "Lowercase library name is not specified. \"$libname_lowercase\" will be used"
fi

if [ -n "$4" ]; then
    libname_uppercase=$4
    echo "Uppercase library name would be \"$libname_uppercase\""
else
    libname_uppercase=$(echo "$libname" | tr "[:lower:]" "[:upper:]")
    echo "Uppercase library name is not specified. \"$libname_uppercase\" will be used"
fi

function replace_libname ()
{
    sed "s/Mylib/$libname/g" |\
    sed "s/mylib/$libname_lowercase/g" |\
    sed "s/MYLIB/$libname_uppercase/g"\
        < /dev/stdin
}

#--------------------------------------------------------------------------------------------------
#
#   Работа с директорией нового проекта
#
#--------------------------------------------------------------------------------------------------

libpath=$1
libdir=$libpath/$libname

if [ -d "$libdir" ]; then
    while true; do
        read -p "Directory $libdir already exists. Override it? (y/N): " choice
        case $choice in
            [Yy] ) break;;
            [Nn] ) exit;;
            ""   ) exit;;
        esac
    done
fi

echo "$libname would be placed into $libdir"
mkdir -p $libdir

#--------------------------------------------------------------------------------------------------
#
#   Генерация
#
#--------------------------------------------------------------------------------------------------

files=$(git ls-files)
for file in $files; do
    new_file=$(echo $file | replace_libname)
    echo "Transforming $file into $libdir/$new_file"
    mkdir -p $(dirname $libdir/$new_file)
    cat $file | replace_libname > .${libname}_buffer_$$
    mv .${libname}_buffer_$$ $libdir/$new_file
done
