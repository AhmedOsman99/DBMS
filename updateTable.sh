#!/bin/bash


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


function Update_Table {
# validation to check if there is tables in database
local check=`ls -1 | wc -l`
if [[ $check == 0 ]] 
then
    echo "---------------------------------"
    echo -e "there is no tables on list"
    echo "---------------------------------"
    ../../tableMenu.sh $1

else
    echo "-------------Tables-----------------------" 
    ls -1 
    echo "-----------------------------------------"
    read -p "Enter name of table: " tableName
    # validation to check the table name is right
    while [ ! -f $tableName.txt ]; 
    do
    echo "-----------------------------------------"
    echo -e "This table is not exist"
    echo "-----------------------------------------"
    read -p "Enter name of table: " tableName          
    done

   # ../../aArray.sh $tableName.txt          
    aArray $tableName.txt
    read -p "Enter column name you want to update: " columnName
     #awk to loop for each field in first line in the table file to get the number of inserted value(colname)
    columnNum=`awk -F "|" -v w="$columnName" '{for(i=1;i<=NF;i++) if($i ~ w){print i}}' $tableName.txt`

    # validation to check if column name entered is exist
    while [ ! $columnNum ];
    do
        echo "---------------------------------------------------------------------------" 
        echo -e "The column name you entered is not exist\ncheck columns in the line below"
        echo "---------------------------------------------------------------------------" 
        head -1 $tableName.txt
        read -p "Enter column name you want to update: " columnName
        columnNum=`awk -F "|" -v w="$columnName" '{for(i=1;i<=NF;i++) if($i ~ w){print i}}' $tableName.txt`
    done          

    type=${colTypes[$columnName]} 
    echo "Column name :$columnName"
    echo "Column datatype : $type"
    read -p "Enter the new value: " value

    # validatiom for column type
    case $type in 
    "int")
    while [[ ! $value =~  ^[0-9]+$ ]]
    do 
    echo "---------------------------------------------------------"
    echo -e "Invalid value for column $columnName of type $type" 
    echo "---------------------------------------------------------"
    read -p "Enter value as integer: " value
    done
    ;;
    "char")
    while [[ ! $value =~ ^[a-zA-Z][a-zA-Z0-9_]{0,50}$ ]]
    do
    echo "---------------------------------------------------------"
    echo -e "Invalid Value for column $columnName of type $type"
    echo "---------------------------------------------------------"
    read -p "Enter value as char: " value
    done 
    ;;
    esac

    read -p "where Primary key is equal: " wherePK
    # validatiom for primary key
    while [ ! $(awk -F "|" -v w="$wherePK" '{if($1 ~ w){print NR}}' $tableName.txt) ]
    do
    echo "---------------------------------------------------------"
    echo -e "This primary key is not exists"
    echo "---------------------------------------------------------"
    read -p "where Primary key is equal: " wherePK
    done
    #awk to get line number that ahve the pk
    lineNum=$(awk "/^${wherePK}/{print NR}" $tableName.txt)

    # Get the line at the specified line number
    line=`grep $wherePK $tableName.txt`

    # Replace the old value with the new value at the specified column number
    new_line=$(echo "${line}" | awk -v new_val=" ${value} " -v columnNum="${columnNum}" 'BEGIN{FS=OFS="|"}{if(NF>=columnNum){$columnNum=new_val}print}')

    # Replace the old line with the new line in the file 
    sed -i "${lineNum}s/.*/${new_line}/" "${tableName}.txt" # -i to overwrite in the original file
    echo "---------------------------------------------------------"
    echo "Your table is updated successfully"
    echo "---------------------------------------------------------"


    
fi
../../tableMenu.sh $1
}
Update_Table $1