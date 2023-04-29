#!/bin/bash

# Main Menu


options=("Create database" "List database" "Connect database" "Drop database" "Exit")
PS3=$'\n'"Select an option: "
select opt in "${options[@]}"
do
 case $opt in
          "Create database")
          ./createDB.sh
          ;;
          "List database")
          ./listDB.sh
          break
          ;;
          "Connect database")
          ./connectDB.sh
          break
          ;;
          "Drop database")
          ./dropDB.sh
          break
          ;;
          "Exit")
          echo "Exiting"
          break
          ;;
          *)
          echo "Invalid option"
          ;;
     esac    
done  