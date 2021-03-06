SPARQL_ENDPOINT=http://data.bibliotheken.nl/sparql  SPARQL_GRAPH="http://data.bibliotheken.nl/thesp/"  FILE_NAME_PREFIX="kb_partition=thesp_set=thes" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
SPARQL_ENDPOINT=http://data.bibliotheken.nl/sparql  SPARQL_GRAPH="http://data.bibliotheken.nl/thesc/"  FILE_NAME_PREFIX="kb_partition=thesc_set=thes" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
SPARQL_ENDPOINT=http://data.bibliotheken.nl/sparql  SPARQL_GRAPH="http://data.bibliotheken.nl/thes/"  FILE_NAME_PREFIX="kb_partition=thes_set=thes" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"

SPARQL_ENDPOINT=http://data.bibliotheken.nl/sparql  SPARQL_GRAPH="http://data.bibliotheken.nl/thesp/wikidata-alignment/"  FILE_NAME_PREFIX="kb_partition=thespWikidataAlignment_set=thes" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
SPARQL_ENDPOINT=http://data.bibliotheken.nl/sparql  SPARQL_GRAPH="http://data.bibliotheken.nl/thesp/dbpedia/"  FILE_NAME_PREFIX="kb_partition=thespDBpedia_set=thes" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
#SPARQL_ENDPOINT=http://data.bibliotheken.nl/sparql  SPARQL_GRAPH="http://data.bibliotheken.nl/nta-dbnla-alignment/"  FILE_NAME_PREFIX="kb_partition=person_set=thes_content=links_ntba" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"  #no links for thesp KB entities

for f in dumps/kb*.nt; do
	lbzip2 $f
done
