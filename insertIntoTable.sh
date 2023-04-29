#!/bin/bash

# function to instantiate associative array to store column names as key and datatypes as value
function aArray {
frow=$(head -1 $1) #variable store the first row in the table file
echo "$frow"
declare -g -A colTypes #associative array
#array store columns name
declare -g colNames=()  
#get first row and replace all | with spaces to store the name in colNames and keys and datatypes in colTypes
for col in ${frow// | / }   
do 
     #get columas name
     name=`echo $col | cut -d "(" -f 1` 
     #get datatype
     type=`echo $col | cut -d ")" -f 1 | cut -d "(" -f 1 --complement` # complement to get char after the delimiter
     colTypes[$name]=$type
     colNames+=("$name")

done
}

function Insert_into_Table {
     local check=`ls -1 | wc -l`

     if [[ $check == 0 ]] 
     then
        echo "-----------------------------------------"
        echo -e "there is no tables on list"
        echo "-----------------------------------------"
        ../../tableMenu.sh $1
     else   
        echo "-------------Tables-----------------------" 
        ls -1 
        echo "-----------------------------------------"
        read -p "Enter the name of the table you want to insert data into: " tablename
        # Check if the table name is valid
        while [ ! -f ./$tablename.txt ] 
        do
        echo "-----------------------------------------"
        echo -e "This table does not exist"
        echo "-----------------------------------------"
        read -p "Enter the name of the table you want to insert data into: " tablename
        done
     fi    
     # Read the column names and types from the table file
     aArray $tablename.txt
     echo -e " " >> $tablename.txt
     for colt in "${colNames[@]}"
     do 
     echo "Column name : $colt"
     type=${colTypes[$colt]} 
     echo "Column datatype : $type"
     read -p "Enter values to insert in column $colt: " value

     # validatiom for primary key
     pk=${colNames[0]}  
     if [[ $colt == $pk ]] 
     then 
     #awk to loop for each first field in all lines in the table file to check if inserted value(pk) is existed
     while [ $(awk -F "|" -v w="$value" '{if($1 ~ w){print NR}}' $tablename.txt) ]
     do
     echo "----------------------------------------------------"
     echo -e "A record with this primary key already exists"
     echo "----------------------------------------------------"
     read -p "Enter the first value as pk: " value
     done
     fi 

     # validatiom for column type of inserted value
     case $type in 
     "int")
     while [[ ! $value =~  ^[0-9]+$ ]]
     do 
     echo "----------------------------------------------------"
     echo -e "\nInvalid value for column $colt of type $type\n" 
     echo "----------------------------------------------------"
     read -p "Enter values to insert numbers: " value
     done
     # append value to the table file
     echo -n "$value | " >> $tablename.txt
     echo "---------------------------------------------"
     echo -e "Values have been inserted successfully"
     echo "---------------------------------------------"
     ;;
     "char")
     while [[ ! $value =~ ^[a-zA-Z][a-zA-Z0-9_]{0,50}$ ]]
     do
     echo "---------------------------------------------------"
     echo -e "\nInvalid Value for column $colt of type $type\n"
     echo "---------------------------------------------------"
     read -p "Enter values to insert char: " value
     done 
     # append value to the table file
     echo -n "$value | " >> $tablename.txt
     echo "---------------------------------------------"
     echo -e "Values have been inserted successfully"
     echo "---------------------------------------------"
     ;;
     esac
     done
     #echo -e " " >> $tablename.txt
     ../../tableMenu.sh $1
}

Insert_into_Table $1