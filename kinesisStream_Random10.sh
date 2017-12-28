#!/bin/bash

## This script will create random data into a Kinesis stream

# Function for the randomWord
randomWord(){
        shuf -n1  /usr/share/dict/words
}

# Get stream name and save as variable. In this test, there is only one stream. If there are more, then you will have add a loop to specify which one you want to have used.
STREAM=`aws kinesis list-streams | grep '        "'|tr -d '        "'`

# loop to put a record loop 10 times and use a random word
N=1
while [ $N -le 10 ]
do
        WORD1=$(randomWord)
        WORD2=$(randomWord)
        echo $WORD1
        aws kinesis put-record --stream-name $STREAM --partition-key 1 --data $WORD1
        echo $WORD2
        aws kinesis put-record --stream-name $STREAM --partition-key 2 --data $WORD2
        echo "$(tput setaf 2)$N Done$(tput sgr0)"
        ((N++))
done
echo All done
