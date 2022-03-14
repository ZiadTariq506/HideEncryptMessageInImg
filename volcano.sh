#!/bin/bash

function spin {

  chars="| / – \\"

  rotations=3

  delay=0.1

  for i in `seq 0 $rotations`; do

    for char in $chars; do 

      echo -ne $char
      sleep $delay
      echo -ne '\b'

    done

  done

}

read -p "Enter the name of the file:" file

read -p "encrypt or decrypt[en/de]:" decision

if [[ "$decision" == "en" ]]
then
	echo  "ur file name is $file" && spin
	# encript the content of the file 
	echo "encrypting..."

	spin && cat "$file"| python3 plain.py > cipher0.txt

	echo "encodeing..." && spin

	openssl base64 -in cipher0.txt -out cipher.txt 
	# hide it in pic 
	steghide embed -cf anon.jpg -ef cipher.txt -sf anonC.jpg
	# delete the encrypted/encoded files
	rm cipher0.txt
	rm cipher.txt
	echo "Go to [anonC.jpg]"
	sleep 1
	echo "looks good to me :)"
elif [[ "$decision" == "de" ]]
then

	echo "ur file name is $file" && spin
	# extract the file from the pic
	steghide extract -sf "$file" -xf decoded.txt
	sleep 1
# test command to see if file exist
if [[ -f "decoded.txt" ]]
then 
	# remove the decoded&decrypted files
	echo "it is here"	# decode
	echo "decodeing..." && spin
	cat decoded.txt | base64 --decode > cipher.txt
	# decryption
	echo "decrypting..." && spin 
	cat cipher.txt | python3 cipher.py > plain.txt
	echo "Go to [plain.txt]"
	rm decoded.txt
	rm cipher.txt
	echo "looks good to me :)"
else
	rm "$file"
	spin
	echo "Who are U!!!!!!!!!!!!"
	echo "The file is Gone :O"
fi	


else 
	echo "something went wrong!!!"
fi
# cat "$file"|base64 >> f1
# check if the password is correct (if the decoded.txt exist)
# E= ls | grep -o -m 1 "decoded.txt"
