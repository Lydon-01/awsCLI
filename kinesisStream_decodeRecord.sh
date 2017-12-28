STREAM=`aws kinesis list-streams | grep '        "'|tr -d '        "'`
ITERATOR=$(aws kinesis get-shard-iterator --shard-id shardId-000000000000 --shard-iterator-type TRIM_HORIZON --stream-name $STREAM | tr -d '{}" ' |sed "s/ShardIterator//g" )
# echo $ITERATOR

DATA=$(aws kinesis get-records --shard-iterator $ITERATOR | grep Data |  tr -d ' ",:' |sed "s/Data//g")

for entry in $DATA
do
	echo -e $entry | base64 --decode
	echo ""
done
