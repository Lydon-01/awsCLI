## Show the Decoded Data in a shard ##

## Things to be improved:
#1 Add an Ask for the Iterator type
#2 
#3 

# Ask which Shard
echo  "$(tput setaf 2)Which Shard are we checking out? Give just the last number (0-999)$(tput sgr0)"
read $SHARD_LAST_NUM
SHARD_ID=shardId-00000000000$SHARD_LAST_NUM # Correctly save the ShardID choice.
echo ""
echo  "$(tput setaf 2)Cool, checking out data on $SHARD_ID.$(tput sgr0)"
echo ""

$ Ask Iterator type
## Ask coming soon.
TYPE=TRIM_HORIZON

# Kinesis Data Stream as a variable. Only works well when there is one. 
STREAM=`aws kinesis list-streams | grep '        "'|tr -d '        "'`

# Saves the Iterator Name of the shard
ITERATOR=$(aws kinesis get-shard-iterator --shard-id shardId-000000000000 --shard-iterator-type $OPTION --stream-name $STREAM | tr -d '{}" ' |sed "s/ShardIterator//g" )
# echo $ITERATOR

DATA=$(aws kinesis get-records --shard-iterator $ITERATOR | grep Data |  tr -d ' ",:' |sed "s/Data//g")

# List all the decoded data
for entry in $DATA
do
	echo -e $entry | base64 --decode
	echo ""
done
