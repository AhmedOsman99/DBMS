#!/bin/bash

function Select_From_Table {
     # validation to check if there is tables in database
     local check=`ls -1 | wc -l`
     if [[ $check == 0 ]] 
     then
          echo "----------------------------------"  
          echo -e "there is no tables yet"
          echo "----------------------------------"
          ../../tableMenu.sh $1
     else
          ls -1
          read -p "Enter name of table: " tableName
          # validation to check the table name is right
          while [ ! -f $tableName.txt ]; 
          do
               echo "----------------------------------"  
               echo -e "This table is not exist"
               echo "----------------------------------"
               read -p "Enter name of table: " tableName          
          done
          read -p "Enter column you want to: " columnName
          read -p "where Primary key is equal: " wherePK
           # validatiom for primary key
          while [[ ! $(awk -F "|" -v w="$wherePK" '{if($1 ~ w){print NR}}' $tableName.txt) && ! -z $wherePK ]]
          do
          echo "---------------------------------------------------------"
          echo -e "This primary key is not exists"
          echo "---------------------------------------------------------"
          read -p "where Primary key is equal: " wherePK
          done
          columnNum=`awk -F "|" -v w="$columnName" '{for(i=1;i<=NF;i++) if($i ~ w){print i}}' $tableName.txt`
          # Get the line at the specified line number
          case "$columnNum,$wherePK" in
          # to select all records
          "","")
          echo "----------------------------------"
          cat $tableName.txt
          echo -e "\n----------------------------------"
          ;;
          # to select all fields of record with specified primary key get row
          "",$wherePK)
          echo "----------------------------------"
          grep "^$wherePK" $tableName.txt
          echo "----------------------------------"
          ;;
          # to select specified field of record with specified primary key
          $columnNum,$wherePK)
          echo "----------------------------------"
          grep "^$wherePK" $tableName.txt | cut -d "|" -f$columnNum
          echo "----------------------------------"
          ;;
          esac
     fi
     ../../tableMenu.sh $1

}
Select_From_Table $1