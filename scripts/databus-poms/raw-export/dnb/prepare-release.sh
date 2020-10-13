#!/bin/bash

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
IN=$BASE/dnb-downloads/$1
OUT=$IN/converted
TMP=$IN/convertedtmp

if [[ -z $1 ]]; then
	        echo "version string is required as argument"
		                exit 1
			fi

function require_cmd () {
	if ! [ -x "$(command -v $1)" ]; then
	       	echo "Error: $1 is not installed." >&2
		exit 1
	fi
}

require_cmd "rdf2rdf"
require_cmd "lbzip2"

####### convert files to ntriples

mkdir -p $OUT
mkdir -p $TMP

for file in $(find $IN -regex ".*gz$")
do
        tmp_name=$(echo ${file##*/} | sed 's,.ttl.gz,.ttl,g')
        new_name=$(echo ${file##*/} | sed 's,.ttl.gz,.nt,g')
        echo -n "converting to nt: $new_name "
        echo -n "> zcat "
        zcat $file > $TMP/$tmp_name
        echo -n "> rdf2rdf "
        rdf2rdf -in $TMP/$tmp_name -out $OUT/$new_name
        echo "> lbzip2"
        lbzip2 $OUT/$new_name
done

rm $TMP/*


####### rename files to contentvariants

for f in $OUT/authorities*; do rename  's/_lds//' $f; done
for f in $OUT/authorities*; do rename  's/authorities-/dnb_set=authorities_partition=/' $f; done



####### copy files to mvn databus plugin folders 

mkdir -p $BASE/authorities/$1
mkdir -p $BASE/links/$1

mv -t $BASE/links/$1 $OUT/*_owlSameAs.nt.bz2
for f in $BASE/links/$1/authorities*; do rename  's/authorities_/links_/' $f; done
mv -t $BASE/authorities/$1 $OUT/authorities*






