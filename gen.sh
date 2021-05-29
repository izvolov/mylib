#!/usr/bin/env bash

if [[ $# -lt 2 || $# -gt 4 ]]; then
    required="<path/to/new/library/directory> <LibraryName>"
    optional="<lowercase_library_name> <UPPERCASE_LIBRARY_NAME>"
    echo "Usage: $0 $required [$optional]"
    exit
fi

libpath=$1
libname=$2
libdir=$libpath/$libname

if [ -n "$3" ]; then
    libname_lowercase=$3
else
    libname_lowercase=$(echo "$libname" | tr "[:upper:]" "[:lower:]")
fi

if [ -n "$4" ]; then
    libname_uppercase=$4
else
    libname_uppercase=$(echo "$libname" | tr "[:lower:]" "[:upper:]")
fi

function replace_libname ()
{
    sed "s/Mylib/$libname/g" |\
    sed "s/mylib/$libname_lowercase/g" |\
    sed "s/MYLIB/$libname_uppercase/g"\
        < /dev/stdin
}

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

files=$(git ls-files)
for file in $files; do
    new_file=$(echo $file | replace_libname)
    mkdir -p $(dirname $libdir/$new_file)
    touch .${libname}_buffer_$$
    cat $file | replace_libname > .${libname}_buffer_$$
    mv .${libname}_buffer_$$ $libdir/$new_file
    echo "Transformed $file into $libdir/$new_file"
done
