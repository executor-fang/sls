#!/bin/sh

discipline_name="Системное программное обеспечение"
project_name="Лабораторная работа №2"
author="Черных Д.С."
aurhor_group="P3312"
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
echo "Скрипт выводит список групп, которым принадлежат более чем указанное количество пользователей"
echo $separator
getent passwd | cut -d: -f1 | xargs groups root | sort -u | nawk -F: -v count="$1" \
'{
	split($2, groups, " ");
	for (group in groups) {
		counts[groups[group]]++;
	}
} END {
	for (group in counts) {
		if (counts[group] > count) {
			print group
		}
	}
}' | sort -u

echo $edge_separator
