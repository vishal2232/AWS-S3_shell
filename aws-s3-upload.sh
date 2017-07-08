#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
file1=$1 		

echo $tests2
if [ $# -eq 1 ] 
then
    echo "searching for $file1"
else
    echo "invalid argument please pass only one argument "
    exit 1
fi


if ping -q -c 1 -W 1 google.com >/dev/null; then
  echo "${green} The INTERNET is working fine..."
else
  echo "${red} The network is down.. Please check your connection."
  exit 1
fi

echo "Uploading a Zip file to s3..."
aws s3 cp $file1 s3://aws.vishal.com/DataGet/
/bin/sleep 4

echo "listing your target bucket folder..."
#xterm -title "AWS listing" -hold -e aws s3 ls aws.vishal.com/dataget &
aws s3 ls aws.vishal.com/DataGet/

/bin/sleep 3 
echo "moving $file1 to data archive folder..."	
aws s3 mv s3://aws.vishal.com/DataGet/$file1 s3://aws.vishal.com/DataArchive/

/bin/sleep 1
exit 1
