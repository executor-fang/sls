#!/bin/bash

# Вариант 13
# Список файлов, для которых заданный пользователь имеет право исполнения.

set -f

[[ ! -n "$1" ]] && echo "Username is required" >&2 && exit 1
[[ $(getent passwd "$1" | wc -l) -ne 1 ]] && echo "User not found" >&2 && exit 1

user="$1"
uid=$(getent passwd "$user" | cut -d':' -f3)

u_pattern='^...[sx]'
g_pattern='^......[sx]'
o_pattern='^.........[xt]'

for file in $(ls); do
    if [ ! -f "$file" ]; then
        continue
    fi

    uid_f=$(ls -n -- "$file" | awk '{ print $3 }') 
    gid_f=$(ls -n -- "$file" | awk '{ print $4 }')

    if [ $uid = $uid_f ]; then
        ls -l -- "$file" | grep -q "$u_pattern" && echo "$file"
        continue
    fi

    for gr in $(groups "$user"); do
        gid=$(getent group "$gr" | cut -d':' -f3)
        if [ $gid = $gid_f ]; then
            ls -l -- "$file" | grep -q "$g_pattern" && echo "$file"
            continue 2
        fi
    done

    ls -l -- "$file" | grep -q "$o_pattern"  && echo "$file"
done

