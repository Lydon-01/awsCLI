
## Show the Decoded Data in a shard ##

## Things to be improved:
#1 Add an Ask for the Iterator type
#2 Add a section for specifying or indicating the key on the data
#3 Make double sure about the max number of out lines

# Ask which Shard
echo "$(tput setaf 2)Which Shard are we checking out? Give just the last number (0-999)$(tput sgr0)"
read SHARD_LAST_NUM
SHARD_ID=shardId-00000000000$SHARD_LAST_NUM # Correctly save the ShardID choice.
echo "$(tput setaf 2)And how many lines of data do you want to see? Number or \"a\" for all.$(tput sgr0)"
read OUT_NUM
echo "$(tput setaf 2)Cool, checking out data on $SHARD_ID.$(tput sgr0)"
echo ""

# Ask Iterator type
## Ask coming soon.
TYPE=TRIM_HORIZON

# Kinesis Data Stream as a variable. Only works well when there is one.
STREAM=`aws kinesis list-streams | grep '        "'|tr -d '        "'`

# Gets the Iterator Name of the previously specified shard
ITERATOR=$(aws kinesis get-shard-iterator --shard-id shardId-000000000000 --shard-iterator-type $TYPE --stream-name $STREAM | tr -d '{}" ' |sed "s/ShardIterator//g" )
# echo $ITERATOR

# Now get the data from the shard, clean up the unwanted text
DATA=$(aws kinesis get-records --shard-iterator $ITERATOR | grep Data |  tr -d ' ",:' |sed "s/Data//g")

# Did they choose to see all lines? Then output the max number of lines
if [ $OUT_NUM == 'a' ]
then
        OUT_NUM=687399551400673279
fi

# Print all the decoded data for X number of ouput lines.
X=1
for entry in $DATA
do
        # echo $X X
        if [ $X -gt $OUT_NUM ]
        then
                break
        fi
        OUT=$(echo -e $entry | base64 --decode)
        echo -e  "\t$OUT"
        ((X++))
done

# Voila
echo --------------
echo "$(tput setaf 2)All done :D$(tput sgr0)"
echo --------------
