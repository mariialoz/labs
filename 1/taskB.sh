#!/bin/bash

echo "Select question:
1. From which ip were the most requests?
2. What is the most requested page?
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP)"
read var
file1=example_log.log
file2=apache_logs.txt

function mostRequests() {
	sort | uniq -c | awk '{ print $1, $2 | "sort -nr "}' | head -n1 | awk '{ print $2 }'
}

function mostRequestedPage() {
	grep "GET" | awk '{print $2}' | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}'
}
function requestsFromIp() {
	grep "GET" | sort | uniq -c | awk '{ print $1,"-", $2 | "sort -nr "}'
}
function nonex() {
        grep "404" | sort | uniq -c | awk '{print $1}'
}
case $var in
  1)
echo "In $file2 ip from were the most requests:"
awk '{ print $1 }' $file2 | mostRequests
echo "In $file1 ip from were the most requests:"
awk '{ print $1 }' $file1 | mostRequests
;;
2)
echo "The most requested page in $file2"
awk '{print $6, $7}' $file2 | mostRequestedPage
echo "The most requested page in $file1"
awk '{print $6, $7}' $file1 | mostRequestedPage
;;
  3)
echo "In $file2 requests from each ip"
awk '{ print $1, $6 }' $file2 | requestsFromIp
echo "In $file1 requests from each ip"
awk '{ print $1, $6 }' $file1 | requestsFromIp
;;
 4)
echo "Number of non-existence pages in example.log"
awk '{print $9}' $file1 | nonex
echo "Numbet of non-existence pages in apache_logs"
awk '{print $7}' $file2 | nonex
;;
 5)
echo "Time with the most request in apache_logs.txt"
awk '{ print $4}' $file2 | cut -c 9-25 | sort | uniq -c | sort -nr | head -n12 | awk '{ print $2 }'
echo "Time with the most requset in example_log.txt:"
awk '{ print $4}' $file1 | cut -c 9-25 | sort |  uniq -c | tail -n1 | awk '{print $2}' |  sort | awk '{print $1}'
;;
6)
echo "Search bots in example_log.log:"
varbot=$(grep "[bB]ot/" $file1 | awk '{print $14, $15, $16}' | grep [bB]ot/ | sed 's/Linux x86_64; //g' | cut -d "/" -f1 | sort | uniq -c | awk '{print $2}')

echo "Search bots in apache_logs.txt:"
grep "[bB]ot/" $file2 | awk '{print $14, $15, $16}' | grep [bB]ot/ | sed 's/Linux x86_64; //g' | cut -d "/" -f1 | sort | uniq -c | awk '{print $2}'
;;
*) 
	  echo "Please, press 1 ||  2 ||  3 ||  4 || 5 || 6"
esac
