#!/bin/bash
git clone https://github.com/dbpedia/dnkg-pilot
cd dnkg-pilot
git pull
cd ..
wget -nc https://github.com/SmartDataAnalytics/RdfProcessingToolkit/releases/download/rdf-processing-toolkit-bundle-1.0.7-SNAPSHOT/rdf-processing-toolkit-bundle-1.0.7-SNAPSHOT-jar-with-dependencies.jar
cartridges=../
cartridge=dblp
dataset=main
version=2020.09.24
rawinput=tmp/downloads/dblp-2020-08-18.nt.gz
for folder in dnkg-pilot/cartridges/$cartridge/$dataset/* ; do
	tmp=tmp/$cartridge/$dataset/$version
	mkdir -p $tmp
	db=$tmp/tdb_files
	type=$(basename $folder)
	echo "processing queries for $folder into $tmp/$type"
#	java -jar rdf-processing-toolkit-bundle-1.0.7-SNAPSHOT-jar-with-dependencies.jar sparql-integrate -e tdb2 --split $tmp/$type $rawinput $folder/*construct --db $db --db-keep --out-format=NTRIPLES
       for f in $tmp/$type/*.nt ; do
	       prop=$(basename $f .nt)
	       fileprefix=${cartridge}_partition\=${type}_set\=${dataset}_content\=
	       if [ $prop == "links" ]; then 
		       file=${fileprefix}links
	       else
		       file=${fileprefix}facts_origin\=${prop}
	       fi
	       echo "sort + dedup + compress $file"
	       LC_ALL=C sort -u $f | lbzip2 -c > $tmp/$type/$file.nt.bz2 
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

