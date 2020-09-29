#!/bin/sh

C="wikidata kadaster nl-dbpedia kb"
for i in ${C}
do 
echo $i 
./test-one.sh https://databus.dbpedia.org/dnkg/cartridges/$i-cartridge  > $i-log.txt 2> $i-log.txt
done
