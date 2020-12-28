BEGIN {
    OFS = " "
    numTags = split("Date Time status PLATE_NUMBER ETC_PRICE VTPAY_CHARGE EPC sessionId",tags)
    for (tagNr=1; tagNr<=numTags; tagNr++) {
        tag = tags[tagNr]
        printf "%s%s", tag, (tagNr<numTags ? OFS : ORS)
    }
}
/= TCOCRequest =/ {
   date = substr($0,1,10)
   time = substr($0,12,12)
}
sub(/^[[:space:]]*([0-9]+\|)?/,"") {
   tag = val = $0
   sub(/[[:space:]]*=.*/,"",tag)
   sub(/[^=]+=[[:space:]]*/,"",val)
   tag2val[tag] = val
}
/^}/ {
   tag2val["Date"] = date
   tag2val["Time"] = time
   for (tagNr=1; tagNr<=numTags; tagNr++) {
       tag = tags[tagNr]
       val = (tag in tag2val ? tag2val[tag] : "Null")
       printf "%s%s", val, (tagNr<numTags ? OFS : ORS)
   }
   delete tag2val
}
