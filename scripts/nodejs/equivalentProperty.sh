#!/bin/bash

#Returns the equivalent properties as CSV of the dbpedia ontology from the extraction-framework server (running locally)
rapper -g http://dief.tools.dbpedia.org/server/ontology/dbpedia.owl | grep equiv | grep Prop  | cut -f1,3 -d '>' | sed -e 's/ /,/g' | sed -e 's/<//g' | sed -e 's/>//g'
