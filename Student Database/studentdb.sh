while test 1 -eq 1
do
echo ----------------------------------------------
echo Enter 1 to add new student details
echo Enter 2 to view all student details
echo Enter 3 to view student details by roll number
echo Enter 4 to find the maximum marks
echo Enter 5 to find the minimum marks
echo Enter 6 to find the average marks of the class
echo Enter 7 to EXIT
echo ----------------------------------------------
echo Enter your choice:
read choice

if ! [[ "$choice" =~ ^[1-7]+$ ]]
then
echo ENTER A VALID CHOICE BETWEEN 1 AND 7

elif test $choice -eq 1
then
echo Enter name of student:
read name
echo Enter roll number:
read roll
echo Enter marks obtained:
read marks

awk -F# -v r=$roll -v n=$name -v m=$marks 'BEGIN {i=0;} {if ($2==r) i++;} END {if (i>0) print "ROLL NUMBER ALREADY EXISTS"; else {printf "%s#%s#%s\n",n,r,m >> "marksheet.txt"; print "STUDENT DETAIL ADDED TO MARKSHEET";}}' marksheet.txt

elif test $choice -eq 2
then
echo -------MARKSHEET-------
awk -F# 'BEGIN {print "Name\t", "Roll\t", "Marks";} {print $1,"\t",$2,"\t",$3;}' marksheet.txt

elif test $choice -eq 3
then
echo Enter roll number to search:
read roll
awk -F# -v r=$roll 'BEGIN {i=0;} {if ($2==r) {print "Roll Number: ",$2,"\nName: ",$1,"\nMarks: ",$3; i++;}} END {if (i==0) print "ROLL NUMBER DOES NOT EXIST";}' marksheet.txt

elif test $choice -eq 4
then
awk -F# 'BEGIN {max=0;} {if (max<$3) max=$3;} END {print "Maximum marks of class is: ",max;}' marksheet.txt

elif test $choice -eq 5
then
awk -F# 'BEGIN {min=1000;} {if (min>$3) min=$3;} END {print "Minimum marks of class is: ",min;}' marksheet.txt

elif test $choice -eq 6
then
awk -F# 'BEGIN {s=0;i=0;} {s=s+$3;i=i+1;} END {s=s/i;print "Average marks of class is: ",s;}' marksheet.txt

elif test $choice -eq 7
then
echo Exiting..
break
fi
done
