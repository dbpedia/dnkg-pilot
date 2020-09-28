#!/bin/sh
CARTRIDGE=$1
#CARTRIDGE="https://databus.dbpedia.org/dnkg/cartridges/kadaster-cartridge"


query="PREFIX dataid: <http://dataid.dbpedia.org/ns/core#>
PREFIX dct:    <http://purl.org/dc/terms/>
PREFIX dcat:   <http://www.w3.org/ns/dcat#>
PREFIX db:     <https://databus.dbpedia.org/>
PREFIX rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:   <http://www.w3.org/2000/01/rdf-schema#>
SELECT DISTINCT ?file WHERE {
	?dataset dcat:distribution ?distribution .
	?distribution dcat:downloadURL ?file .
	?dataset dataid:artifact <$CARTRIDGE> .
	{
		?distribution dct:hasVersion ?version {
			SELECT (?v as ?version) { 
				?dataset dataid:artifact <$CARTRIDGE> . 
				?dataset dct:hasVersion ?v . 
			} ORDER BY DESC (?version) LIMIT 1 
		}
	}
	{ ?distribution <http://dataid.dbpedia.org/ns/core#compression> 'bzip2'^^<http://www.w3.org/2001/XMLSchema#string> . }
}
"


files=$(curl -H "Accept: text/csv" --data-urlencode "query=${query}" https://databus.dbpedia.org/repo/sparql | tail -n+2 | sed 's/"//g')
rm -r /tmp/cartridgestats
mkdir /tmp/cartridgestats
echo -n "" > /tmp/cartridgestats/predicates.lst
echo -n "" > /tmp/cartridgestats/subjects.lst
for f in ${files} ; do 
    echo "processing $f"
	curl $f > /tmp/cartridgestats/current.bz2
	lbzip2 -dc /tmp/cartridgestats/current.bz2 | grep -Po '^{"predicate":{"@id":"\K(.*)(?="},"subject")'| sort | uniq -c | sort -nr  >> /tmp/cartridgestats/predicates.lst 
	lbzip2 -dc /tmp/cartridgestats/current.bz2 | grep -Po '"subject":{"@id":"\K(.*)(?="},"objects")' | sort -u >> /tmp/cartridgestats/subjects.lst 
done
echo 
"###################
not rewritten preds
###################"
grep -v 'global.dbpedia.org' | grep -v 'dbpedia.org/ontology' /tmp/cartridgestats/predicates.lst 

echo 
"###################
preds not in id mapping
###################"
grep  'global.dbpedia.org'  /tmp/cartridgestats/predicates.lst 

NOTR=`grep -v 'global.dbpedia.org'  /tmp/cartridgestats/subjects.lst | wc -l`
R=`grep  'global.dbpedia.org'  /tmp/cartridgestats/subjects.lst | wc -l`
TOTAL=`wc -l /tmp/cartridgestats/subjects.lst`

echo "###################
not rewritten subjects: $NOTR
rewritten subjects: $R
total subjects: $TOTAL
###################"

echo "DETAILS: 
ls /tmp/cartridgestats"




