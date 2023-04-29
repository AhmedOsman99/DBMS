#!/bin/bash
function Create_Table {
ls
read -p "Enter the name of the table you want to create: " tableName

# Check if the table name is valid
if [[ ! $tableName =~ ^[a-zA-Z][a-zA-Z0-9_]{0,50}$ ]]; 
then
    echo "-----------------------"
    echo -e "Invalid table name"
    echo "-----------------------"
    clear
    ../../tableMenu.sh $1

# Check if the table already exists
elif [ -f $tableName.txt ]; 
then
    echo "------------------------------"
    echo -e "This table already exists"
    echo "------------------------------"
    clear
    ../../tableMenu.sh $1
else
    touch $tableName.txt
    # Ask the user for the number of columns

    read -p "Enter number of columns: " counter
    while [[ ! $counter =~ [0-9]$ ]]
    do
    echo "number of columns must be integer "
    read -p "Enter number of columns: " counter
    done
    echo "---------------------------------------------------------------------------------------"
    echo "--------Make sure that the first column would be automatically ( Primary Key )---------"
    echo "---------------------------------------------------------------------------------------"
    # Check if the column names and types are valid
    for ((i=1; i<$counter+1; i++));
    do   
        read -p "Enter column name: " columnName
        while [[ ! $columnName =~ ^[a-zA-Z][a-zA-Z0-9_]{0,50}$ ]]; 
        do
            echo "------------------------------------------------------------------------------"
            echo -e "Invalid column name\nColumn name must start with alphabitical character"
            echo "------------------------------------------------------------------------------"
            read -p "Enter column name: " columnName
        done

        PS3=$'\n'"Select an option: "
        select opt in "char" "int"
        do
        case $opt in
            "char") #set column datatype as char 
            dataType="char"
            break;;
            "int") #set column datatype as int
            dataType="int" 
            break;;
        esac
        done
        

        # Create a new file for the table and add the column names and types as the first line
        echo -n "$columnName($dataType)  |  " >> $tableName.txt
    done
    
        echo "-----------------------------------------------"
        echo -e "Your table has been created successfully"
        echo "-----------------------------------------------"

        ../../tableMenu.sh $1
fi
}
Create_Table $1