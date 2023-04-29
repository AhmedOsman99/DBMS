
#!/bin/bash

echo "----------Available Databases------------"
ls -1 ./Databases
echo "-----------------------------------------"
read -p "Enter database name: " dbName
if [ -d ./Databases/$dbName ]
then 
rm -r ./Databases/$dbName
echo "--------------------------------------"
echo  "Database $dbName dropped successfully"
echo "--------------------------------------"
./main.sh
else
echo "-------------------------------"
echo "Database $dbName does not exist"
echo "-------------------------------"
./main.sh
fi