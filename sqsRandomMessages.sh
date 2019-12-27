## Simple one-liner bash script to put messages into a SQS queue
## Messages will be in CSV format with an itirating id, random word and epoc time. 

for i in $(seq 1 100); do word=$(cat /usr/share/dict/words|sort -R|head -n 1|xargs echo); aws sqs send-message --queue-url https://sqs.us-east-1.amazonaws.com/076590427499/test --message-body "$i,$word,$(date +%s)"; done;
