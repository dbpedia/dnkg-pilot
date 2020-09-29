#!/bin/sh
CARTRIDGE=$1
#CARTRIDGE="https://databus.dbpedia.org/dnkg/cartridges/kadaster-cartridge"

## SETUP
TMPFOLDER="/tmp/cartridgestats/"`echo -n $CARTRIDGE | sed 's|^https://databus.dbpedia.org/dnkg/cartridges/||'`
rm -r $TMPFOLDER
mkdir -p $TMPFOLDER
echo -n "" > $TMPFOLDER/predicates.lst
echo -n "" > $TMPFOLDER/subjects.lst

## GET DOWNLOADURLs
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

## DOWNLOAD
files=$(curl -H "Accept: text/csv" --data-urlencode "query=${query}" https://databus.dbpedia.org/repo/sparql | tail -n+2 | sed 's/"//g')

## PROCESS
for f in ${files} ; do 
    echo "processing $f"
	curl -s $f > /tmp/cartridgestats/current.bz2
	lbzip2 -dc /tmp/cartridgestats/current.bz2 | grep -Po '^{"predicate":{"@id":"\K(.*)(?="},"subject")' >> $TMPFOLDER/predicates.all.lst 
	cat $TMPFOLDER/predicates.all.lst 	| sort | uniq -c | sort -nr > $TMPFOLDER/predicates.lst  
	lbzip2 -dc /tmp/cartridgestats/current.bz2 | grep -Po '"subject":{"@id":"\K(.*)(?="},"objects")' | sort -u >> $TMPFOLDER/subjects.lst 
done


#PRED 1
#FOUNDPRED1=`cat $TMPFOLDER/predicates.lst  | grep -vE '(dbpedia.org/ontology|global.dbpedia.org/property|www.w3.org/2000/01/rdf-schema|www.w3.org/1999/02/22-rdf-syntax-ns)'`
#echo "###################
#not rewritten preds, i.e. using raw vocab :
#$FOUNDPRED1
#(SHOULD BE EMPTY)
###################"



# PREDS 
NOTR=`grep -v 'global.dbpedia.org' $TMPFOLDER/predicates.lst | wc -l`
R=`grep  'global.dbpedia.org'  $TMPFOLDER/predicates.lst | wc -l`
TOTAL=`cat $TMPFOLDER/predicates.lst | wc -l`

echo "###################
total predicates: $TOTAL
rewritten predicates: $R
NOT REWRITTEN SUBJECTS: $NOTR (SHOULD BE 0)
###################"



NOTR=`grep -v 'global.dbpedia.org' $TMPFOLDER/subjects.lst | wc -l`
R=`grep  'global.dbpedia.org'  $TMPFOLDER/subjects.lst | wc -l`
TOTAL=`cat $TMPFOLDER/subjects.lst | wc -l`

echo "###################
total subjects: $TOTAL
rewritten subjects: $R
NOT REWRITTEN SUBJECTS: $NOTR (SHOULD BE 0)
###################"

echo "DETAILS: 
ls $TMPFOLDER"




