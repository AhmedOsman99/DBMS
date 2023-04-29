#!/bin/bash

function List_Tables {

    local check=`ls -1 | wc -l`

     if [[ $check == 0 ]] 
     then
        echo "--------------------------------"
        echo -e "\nthere is no tables on list\n"
        echo "--------------------------------"
        ../../tableMenu.sh $1
     else   
         echo "-----------Tables -------------"
         ls -1 
         echo "--------------------------------"
        ../../tableMenu.sh $1
     fi    
     
}
List_Tables $1