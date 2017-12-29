#!/bin/bash
## This script will create random data into a Kinesis stream
## Still To do: 
#1 Fix Word3 to have a bigger data entry
#2 Better understand the partition key and how to use it correctly
#3 
#4 

# Function for the randomWord
randomWord(){
        shuf -n1  /usr/share/dict/words
}

# Get stream name and save as variable. In this test, there is only one stream. If there are more, then you will have add a loop to specify which one you want to have used.
STREAM=`aws kinesis list-streams | grep '        "'|tr -d '        "'`


# How many puts? 
echo "$(tput setaf 2)$N How many Put-Records would you like to \do?$(tput sgr0)"
read COUNT
echo "$(tput setaf 2)$N Okay. Doing $COUNT Put-Records into Stream $STREAM.$(tput sgr0)"
echo ""

# loop to put a record loop 10 times and use a random word
N=1
while [ $N -le $COUNT ]
do
        WORD1=$(randomWord)
        WORD2=$(randomWord) # Using two word so that you can play with different partition keys
        ## Word3 feature coming soon.
        #WORD3="$(randomWord) $(randomWord) $(randomWord)  $(randomWord) $(randomWord) $(randomWord)"

        echo $WORD1
        aws kinesis put-record --stream-name $STREAM --partition-key 1 --data $WORD1
        echo $WORD2 
        aws kinesis put-record --stream-name $STREAM --partition-key 2 --data $WORD2 
        ## Word3 feature coming soon.
        #echo $WORD3
        #aws kinesis put-record --stream-name $STREAM --partition-key 2 --data $WORD3
        
        echo "$(tput setaf 2)$N Done$(tput sgr0)"
        ((N++))
done
echo All done
