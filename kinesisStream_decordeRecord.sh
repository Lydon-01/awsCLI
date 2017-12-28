ITERATOR=$(aws kinesis get-shard-iterator --shard-id shardId-000000000000 --shard-iterator-type TRIM_HORIZON --stream-name TempStream2 | tr -d '{}" ' |sed "s/ShardIterator//g" )
echo $ITERATOR
aws kinesis get-records --shard-iterator $ITERATOR | grep Data
