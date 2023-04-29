#!/bin/bash

function TableMenu {

echo -e "\nYou are in $1 database\n"
options=("Create Table" "List Tables" "Drop Table" "Insert into Table"
 "Select From Table" "Delete From Table" "Update Table" "Exit")
PS3=$'\n'"Select an option: "
select opt in "${options[@]}"
do
case $opt in
    "Create Table")
    ../../createTable.sh $1
    break
    ;;
    "List Tables")
    ../../listTable.sh $1
    break
    ;;
    "Drop Table")
    ../../dropTable.sh $1
    break
    ;;
    "Insert into Table")
    ../../insertIntoTable.sh $1
    break
    ;;
    "Select From Table")
    ../../selectFromTable.sh $1
    break
    ;;
    "Delete From Table")
    ../../deleteFromTable.sh $1
    break
    ;;
    "Update Table")
    ../../updateTable.sh $1
    break
    ;;
    "Exit")
    echo "Exiting"
    break
    ;;
    *)
    echo "Invalid option"
    ;;
esac    
done
     
}
TableMenu $1