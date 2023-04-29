 #!/bin/bash
read -p "Enter the name of db you want to create: " dbName
# check=`ls ./Databases | grep -w "$dbname"` =========== [ $check ]
if [[ ! $dbName =~ ^[a-zA-Z][a-zA-Z0-9_]{0,100}$ ]]
then 
    echo "------------------------------"
    echo -e "\nInvalid database name\n"
    echo "------------------------------"
    ./main.sh
elif [ -d ./Databases/$dbName ]
then
    echo "---------------------------------------"
    echo -e "\nThis database is already existed\n"
    echo "---------------------------------------"
    ./main.sh
else
    mkdir ./Databases/$dbName
    echo "-----------------------------------------------"
    echo -e "\nYour database has been created succsessfully\n"
    echo "-----------------------------------------------"
fi     