#!/bin/bash

# Вариант 2
# Список пользователей, имеющих право чтения заданного файла.

[[ ! -n "$1" ]] && echo "One argument is required" >&2 && exit 1
[[ ! -f "$1" ]] && echo "$1 is not a file" >&2 && exit 1

file="$1"
file_owner=$(ls -n -- "$file" | nawk '{print $3}')
file_owner_group=$(ls -n -- "$file" | nawk '{print $4}')
group_members=$(getent group "$file_owner_group" | cut -d':' -f4)

u_pattern='^.r'
g_pattern='^....r'
o_pattern='^.......r'

for user_id in $(getent passwd | cut -d':' -f3); do
    
    if [ "$user_id" = "$file_owner" ]; then
        ls -l -- "$file" | grep -q "$u_pattern" && getent passwd "$user_id" | cut -d: -f1 && continue
    fi

    for member in "$group_members"; do
        if [ "$user_id" = "$member" ]; then
            ls -l -- "$file" | grep -q "$g_pattern" && getent passwd "$user_id" | cut -d: -f1 &&
            continue 2
        fi
    done

    ls -l -- "$file" | grep -q "$o_pattern" && getent passwd "$user_id" | cut -d: -f1 && continue
       
done

