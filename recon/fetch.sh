#!/bin/bash

urls=("/" "forum" "agenda" "projects" "forum/6viy7xi64gxpan3" "newsletter" "agenda" "staff" "staff/dashboard" "admin" "api/users" "api/grades" "api/docs-internal" "/internal" "backup" "static/uploads/" "/_/")
session_cookie='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlbnBsd2h1OGpmbzU2b2kiLCJsb2dpbiI6InNvcGhpZSIsInJvbGUiOiJnb2QiLCJleHAiOjE3OTA4NzEwMDJ9.X7OSKsd2xJtp6-He_L76g15n6XGV0hgnZ4HqdvshlEU'


for endpoint in "${urls[@]}"; do
    echo "Fetching --> " "http://localhost:4942/$endpoint"
    echo
    curl -s --cookie "session=$session_cookie" "http://localhost:4942/$endpoint" | grep -Pzo '(?s)<!--.*?-->'
    echo
done


# for item in "${my_array[@]}"; do
#     echo "Fruit: $item"
# done
