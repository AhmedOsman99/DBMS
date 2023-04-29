#!/bin/bash

function Delete_From_Table {
     # validation to check if there is tables in database
     local check=`ls -1 | wc -l`
     if [[ $check == 0 ]] 
     then
          echo "----------------------------------"  
          echo -e "there is no tables yet"
          echo "----------------------------------"  
          ../../tableMenu.sh $1
     else
          echo "----------------------------------"  
          ls -1
          echo "----------------------------------"  
          read -p "Enter name of table: " tableName
          # validation to check the table name is right
          while [ ! -f $tableName.txt ]; 
          do
               echo "----------------------------------"  
               echo -e "This table is not exist"
               echo "----------------------------------"  
               read -p "Enter name of table: " tableName          
          done
          read -p "where Primary key is equal: " wherePK
          # validatiom for primary key
          while [[ ! $(awk -F "|" -v w="$wherePK" '{if($1 ~ w){print NR}}' $tableName.txt) && ! -z $wherePK ]]
          do
          echo "---------------------------------------------------------"
          echo -e "This primary key is not exists"
          echo "---------------------------------------------------------"
          read -p "where Primary key is equal: " wherePK
          done
          case "$wherePK" in
          # to delete all records 
          "")
          sed -i '2,$d' $tableName.txt
          echo "All rows are deleted"
          ;;
          # to delete specific record
          $wherePK)
          sed -i "/^$wherePK/d" $tableName.txt
          echo "Row with primary key $wherePK deleted"
          ;;
          esac
     fi
     ../../tableMenu.sh $1
}

Delete_From_Table $1
