#!/bin/sh

discipline_name="Системное программное обеспечение"
project_name="Лабораторная работа №2. Часть 1."
author="Черных Д.С."
author_group="P3312"
variant="2"
edge_separator="---------------------------------------"
separator="+++++++++++++++++++++++++++++++++++++++"

echo $edge_separator
echo $discipline_name
echo $project_name
echo "Автор: $author"
echo "Группа: $author_group"
echo "Вариант: $variant"
echo ""
echo "Данный скрипт выводит списки имён каталогов в каталоге с путём \"$1\", имеющих не менее одного подкаталога. Список сортируется по времени модификации."
echo $separator
if [ ! -z $1 ]
	then	
		ls -lAtb -- "$1" | grep "^d" | awk '{ if ($2 > 2) { print "\""$9"\\n\"" } }' | xargs -L 1 printf 2>>/dev/null || echo 'В указанном аргументе отсутствуют нужные каталоги или он некорректен' 1<&2
	else
		echo 'Вы не указали ни одного аргумента'
fi
echo $edge_separator
