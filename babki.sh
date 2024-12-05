#!/bin/bash

if ! command -v curl &> /dev/null; then
    echo "Утилита curl не установлена. Пожалуйста, установите её."
    exit 1
fi
if ! command -v jq &> /dev/null; then
    echo "Утилита jq не установлена. Пожалуйста, установите её."
    exit 1
fi

if [ "$#" -ne 1 ]; then
    echo "Использование: $0 <имя_пользователя_GitHub>"
    exit 1
fi
USERNAME=$1
API_URL="https://api.github.com/users/$USERNAME/repos"
response=$(curl -s "$API_URL")
if [ $? -ne 0 ]; then
    echo "Ошибка при получении данных от GitHub."
    exit 1
fi
echo "Имя репозитория          | Дата создания         | Количество звезд"
echo "-------------------------|-----------------------|-------------------"
echo "$response" | jq -r '.[] | [.name, .created_at, .stargazers_count] | @tsv' | while IFS=$'\t' read -r name created_at stars; do
    printf "%-24s | %-21s | %d\n" "$name" "$created_at" "$stars"
done
