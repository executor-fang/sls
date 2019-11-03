#!/bin/sh

ERR_PATH="$HOME/lab1_err"
SEPARATOR_STRING="-------------------------------------------------------------"
SEPARATOR_ANSWER_STRING="+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

while [ "$script" != 6 ]
do
    echo 'Скрипт для первой лабораторной работы по ОСП'
    echo 'Вариант 4'
    echo 'Автор: Черных Д.С.'
    echo 'Группа: P3312'
    echo $SEPARATOR_STRING
    echo '1. Напечатать имя текущего каталога'
    echo '2. Сменить текущий каталог'
    echo '3. Выдать список пользователей, имеющих хотя бы один процесс'
    echo '4. Создать файл'
    echo '5. Скопировать файл'
    echo '6. Выйти из программы'
    echo $SEPARATOR_STRING
    echo 'Введите номер выбранного пункта меню:'
    
    read script || break

    case "$script" in
        1)
            echo $SEPARATOR_ANSWER_STRING
            pwd 2>> "$ERR_PATH" || echo 'Не удалось напечатать имя текщего каталога!' 1>&2
            echo $SEPARATOR_ANSWER_STRING
        ;;
        2)
            echo $SEPARATOR_ANSWER_STRING
            echo 'Введите путь назначения для смены текущего каталога'
            read cdpath || break
            cd $cdpath 2>> "$ERR_PATH" || echo 'Не удалось сменить текущий каталог' 1>&2
            echo $SEPARATOR_ANSWER_STRING
        ;;
        3)
            echo $SEPARATOR_ANSWER_STRING
            w | awk '{print $1}' | tail -n +3 2>> "$ERR_PATH" || echo 'Не удалось вывести список пользователей имеющих хотя бы один процесс' 1>&2
            echo $SEPARATOR_ANSWER_STRING
        ;;
        4)
            echo $SEPARATOR_ANSWER_STRING
            echo 'Введите название файла'
            read file_name || break
            echo 'Введите путь, где файл должен быть создан'
            read file_path || break
            touch $file_path/$file_name 2>> "$ERR_PATH" || echo 'Не удалось создать файл с указанным путём' 1>&2
            echo $SEPARATOR_ANSWER_STRING
        ;;
        5)
            echo $SEPARATOR_ANSWER_STRING
            echo 'Введите название файла, который должен быть скопирован'
            read file_to_copy_name || break
            echo 'Введите путь, куда файл должен быть скопирован'
            read file_to_copy_path || break
            cp $file_to_copy_name $file_to_copy_path 2>> "$ERR_PATH" || echo 'Не удалось скопировать файл в указанный путь' 1>&2
            echo $SEPARATOR_ANSWER_STRING
        ;;
    esac
done
