#!/bin/bash
git clone https://github.com/dbpedia/dnkg-pilot
cd dnkg-pilot
git pull
cd ..
wget -nc https://github.com/SmartDataAnalytics/RdfProcessingToolkit/releases/download/rdf-processing-toolkit-bundle-1.0.7-SNAPSHOT/rdf-processing-toolkit-bundle-1.0.7-SNAPSHOT-jar-with-dependencies.jar
cartridges=../
cartridge=$1
dataset=$2
version=$3
rawinput=kadaster_partition\=bag.nt.bz2

mkdir -p tmp/downloads
rm -rf tmp/downloads/dnkg

query=$(cat <<-END
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX db: <https://databus.dbpedia.org/>
PREFIX dcat: <http://www.w3.org/ns/dcat#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX dataid: <http://dataid.dbpedia.org/ns/core#>
SELECT DISTINCT ?file WHERE
{ 
	{
		SELECT DISTINCT ?file WHERE {
			?dataset dcat:distribution ?distribution .
			?distribution dcat:downloadURL ?file .
			{
				?dataset dataid:group <https://databus.dbpedia.org/dnkg/raw-exports> .
				{
					?dataset dataid:artifact <https://databus.dbpedia.org/dnkg/raw-exports/$cartridge> .
					{
						?distribution dct:hasVersion ?version {
							SELECT (?v as ?version) { 
								?dataset dataid:artifact <https://databus.dbpedia.org/dnkg/raw-exports/$cartridge> . 
								?dataset dct:hasVersion ?v . 
							} ORDER BY DESC (?version) LIMIT 1 
						}
					}
					{ ?distribution <http://dataid.dbpedia.org/ns/core#formatExtension> 'nt'^^<http://www.w3.org/2001/XMLSchema#string> . }
		#			{ ?distribution <http://dataid.dbpedia.org/ns/cv#set> '$dataset'^^<http://www.w3.org/2001/XMLSchema#string> . }
				}
			}
		}
	}
 }
END
)

echo "$query" > query.sparql

docker run --rm --name databus-client \
    -v $(pwd)/query.sparql:/opt/databus-client/query.sparql \
    -v $(pwd)/tmp/downloads:/var/repo \
    dbpedia/databus-client


rawinput=tmp/downloads/dnkg/raw-exports/$cartridge/*/*.*


for folder in dnkg-pilot/cartridges/$cartridge/$dataset/* ; do
	tmp=tmp/$cartridge/$dataset/$version
	mkdir -p $tmp
	db=$tmp/tdb_files
	type=$(basename $folder)
	echo "processing queries for $folder into $tmp/$type"
	java -jar rdf-processing-toolkit-bundle-1.0.7-SNAPSHOT-jar-with-dependencies.jar sparql-integrate -e tdb2 --split $tmp/$type $rawinput $folder/*construct --db $db --db-keep --out-format=NTRIPLES
       for f in $tmp/$type/*.nt ; do
	       prop=$(basename $f .nt)
	       echo $prop
	       fileprefix=${cartridge}_partition\=${type}_set\=${dataset}_content\=
	       if [ $prop == "links" ]; then 
		       file=${fileprefix}links
	       else
		       file=${fileprefix}facts_origin\=${prop}
	       fi
	       echo "sort + dedup + compress $file"
	       if [ $prop == "export" ]; then
		       LC_ALL=C sort -u $f | grep -v "> <https?://schema.org/sameAs> <" | grep -v "> <http://www.w3.org/2002/07/owl#sameAs> <"  | lbzip2 -c > $tmp/$type/$file.nt.bz2 
	       else
		       LC_ALL=C sort -u $f | lbzip2 -c > $tmp/$type/$file.nt.bz2 
	       fi
       done

       grep "> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <" $tmp/$type/export.nt | LC_ALL=C sort -u | lbzip2 -c > $tmp/$type/${fileprefix}types.nt.bz2

 :' for construct in $folder/*.pt-construct ; do 
	  prop=$(basename $construct .pt-construct)
	  type=$(basename $folder)
	  file=${cartridge}_partition\=${type}_prop\=$prop
	  if test -f "dumps/$file.nt"; then
		echo "skipping export for $file since it already exists"
	  else
	  	echo "extracting construct to file: $file"
	  	SPARQL_ENDPOINT=http://akswnc7.informatik.uni-leipzig.de:8897/sparql  SPARQL_CONSTRUCT=$(cat $construct) FILE_NAME_PREFIX=$file mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
  	  fi
   done  '
done

