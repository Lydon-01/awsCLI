!#/bin/bash
## Use this script (or just copy the command) to get a the total size of files below a certain folder (key) in your S3 bucket

# UPDATE THIS! What is the bucket and key?
# example: s3://my_bucket/big_folder/
S3_DIR='s3://*YOUR_BUCKET/KEY*'

# Get the total size
aws s3 ls $S3_DIR --summarize --recursive | grep "Total Size" | grep "Total Size"

# Convert total size to MB and GB. And print
RAW_SIZE=`aws s3 ls $S3_DIR --summarize --recursive | grep "Total Size" | cut -f 6 -d ' '`
MB=$(($RAW_SIZE / 10**6))
echo $MB "Megabytes"
GB=$(($RAW_SIZE / 10**9))
echo $GB "Gigabytes"


# Or, here is the single line command
S3_DIR='s3://*YOUR_BUCKET/KEY*'
aws s3 ls $S3_DIR --summarize --recursive | grep "Total Size" | cut -f 6 -d ' '| awk '{ SUM += $1 } END { print SUM / 10**9 }' && echo " Gigabytes"
