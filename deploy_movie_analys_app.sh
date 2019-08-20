#!/bin/bash

command -v git >/dev/null 2>&1 || { echo >&2 "Git is required but not installed.  Aborting."; exit 1; }
command -v docker >/dev/null 2>&1 || { echo >&2 "Docker is required but not installed.  Aborting."; exit 1; }

db_host=""
api_host=""
ui_host=""

db_port=3306
api_port=8000
ui_port=8080


select_ports() {
    read -p "Insert db port " db_port
    read -p "Insert api port " api_port
    read -p "Insert ui port " ui_port
}

db_user="user"
db_password="password"
db_root_password="password"

select_database_profile() {
    read -p "Insert root password " db_root_password
    read -p "Insert application user " db_user
    read -p "Insert application's user password " db_password 
}

echo "Do you wish to use the deafult ports?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) select_ports; break;;
    esac
done

echo "Database port is set to be $db_port"
echo "Api port is set to be $api_port"
echo "Ui port is set to be $ui_port"

echo "Do you wish to use the deafult database users and passwords?"
echo "WARNING, using the default user profiles is unsafe and not recomended"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) select_database_profile; break;;
    esac
done

echo "root user password set... "
echo "Application user profile set, user name set to $db_user"
echo "$db_user is a read only user"

git clone --single-branch --branch develop https://github.com/DavidChaMun/movie-analyst-ui.git
git clone --single-branch --branch develop https://github.com/DavidChaMun/movie-analyst-api.git