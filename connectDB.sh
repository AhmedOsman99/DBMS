 #!/bin/bash

function Connect_database { 
     echo "----------Available Databases----------"
     ls -1 ./Databases
     echo "---------------------------------------"

     read -p "Enter database name: " dbName
     if [ -d ./Databases/$dbName ]
     then
     cd ./Databases/$dbName
     echo "------------------------------"
     echo "Connected to $dbName Database "
     echo "------------------------------"
     #opening of database options menu
     clear
     ../../tableMenu.sh $dbName
     else
     echo "------------------------------"
     echo -e "\n Database $dbName not found \n"
     echo "------------------------------"
     clear
     ./main.sh
     fi
}
Connect_database