#!/bin/bash

function Drop_Table {
     local check=`ls -1 | wc -l`
     if [[ $check == 0 ]] 
     then
     echo "-----------------------------------------"
     echo -e "\nthere is no tables on list\n"
     echo "-----------------------------------------"
         
        ../../tableMenu.sh $1
     else 
     echo "---------Available Tables------------"  
         ls -1 
     echo "---------------------------------------"
    
     read -p "Enter Tabke name: " tname  
     if [ -f ./$tname.txt ]
     then 
     rm  ./$tname.txt
     echo "-----------------------------------------"
     echo  "Table $tname dropped successfully"
     echo "-----------------------------------------"
     ../../tableMenu.sh $1
     else
     echo "-----------------------------------------"
     echo "Table $tname does not exist"
     echo "-----------------------------------------"
     ../../tableMenu.sh $1
     fi
     fi    
}
Drop_Table $1
