#!/bin/bash

function listDatabase {

     local check=`ls -1 ./Databases| wc -l`

     if [[ $check == 0 ]] # exit status of the ls command 0 success
     then
        echo "-------------------------------"
        echo -e "\nthere is no databases yet\n"
        echo "-------------------------------"
        ./main.sh
     else 
         echo "--------Databases------------"  
         ls -1 ./Databases
         echo "------------------------------"
         ./main.sh
     fi    
}
listDatabase