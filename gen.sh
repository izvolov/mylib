#!/usr/bin/env bash

###################################################################################################
##
##  Скрипт позволяет генерировать проект с заданным именем
##
###################################################################################################

if [[ $# -lt 2 || $# -gt 4 ]]; then
    required="<path/to/new/project/directory> <ProjectName>"
    optional="<lowercase_project_name> <UPPERCASE_PROJECT_NAME>"
    echo "Usage: $0 $required [$optional]"
    exit
fi

#--------------------------------------------------------------------------------------------------
#
#   Работа с именем нового проекта
#
#--------------------------------------------------------------------------------------------------

project_name=$2

echo "Project name would be \"$project_name\""

if [ -n "$3" ]; then
    project_name_lowercase=$3
    echo "Lowercase project name would be \"$project_name_lowercase\""
else
    project_name_lowercase=$(echo "$project_name" | tr "[:upper:]" "[:lower:]")
    echo "Lowercase project name is not specified. \"$project_name_lowercase\" will be used"
fi

if [ -n "$4" ]; then
    project_name_uppercase=$4
    echo "Uppercase project name would be \"$project_name_uppercase\""
else
    project_name_uppercase=$(echo "$project_name" | tr "[:lower:]" "[:upper:]")
    echo "Uppercase project name is not specified. \"$project_name_uppercase\" will be used"
fi

function replace_project_name ()
{
    sed "s/Mylib/$project_name/g" |\
    sed "s/mylib/$project_name_lowercase/g" |\
    sed "s/MYLIB/$project_name_uppercase/g"\
        < /dev/stdin
}

#--------------------------------------------------------------------------------------------------
#
#   Работа с директорией нового проекта
#
#--------------------------------------------------------------------------------------------------

project_path=$1
project_dir=$project_path/$project_name

if [ -d "$project_dir" ]; then
    while true; do
        read -p "Directory $project_dir already exists. Override it? (y/N): " choice
        case $choice in
            [Yy] ) break;;
            [Nn] ) exit;;
            ""   ) exit;;
        esac
    done
fi

echo "$project_name would be placed into $project_dir"
mkdir -p $project_dir

#--------------------------------------------------------------------------------------------------
#
#   Генерация
#
#--------------------------------------------------------------------------------------------------

files=$(git ls-files)
for file in $files; do
    new_file=$(echo $file | replace_project_name)
    echo "Transforming $file into $project_dir/$new_file"
    mkdir -p $(dirname $project_dir/$new_file)
    cat $file | replace_project_name > .${project_name}_buffer_$$
    mv .${project_name}_buffer_$$ $project_dir/$new_file
done
