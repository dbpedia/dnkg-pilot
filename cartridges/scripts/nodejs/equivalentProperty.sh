#!/bin/bash

#Returns the equivalent properties as CSV of the dbpedia ontology from the extraction-framework server (running locally)
rapper -g http://95.217.38.103:9990/server/ontology/dbpedia.owl | grep equiv | grep Prop  | cut -f1,3 -d '>' | sed -e 's/ /,/g' | sed -e 's/<//g' | sed -e 's/>//g'
