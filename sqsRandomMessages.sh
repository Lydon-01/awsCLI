## Simple one-liner bash script to put messages into a SQS queue
## Messages will be in CSV format with an itirating id, random word and epoc time. 

for i in $(seq 1 1000); do aws sqs send-message --queue-url https://sqs.us-east-1.amazonaws.com/YOURACCOUNTID/YOURQUEUE --message-body $i,$(cat /usr/share/dict/words|sort -R|head -n 1|xargs echo),$(date +%s); done;
