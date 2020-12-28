#!/bin/bash

echo "Date|Time|status|PLATE_NUMBER|ETC_PRICE|VTPAY_CHARGE|EPC|sessionId" > output
awk -f tst.awk ../tcocmsg.log | column -s$' ' -t | sort -r -k8 | uniq -f7 -c | \
awk '{if ($1 == "2") {print $1 " " $2 " " $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9}}' | \
awk 'BEGIN{OFS="|";} {if ($4 == "2001" || $4 == "2002") {print $2,$3,$4,$5,$6,$7,$8,$9}}' >> output
