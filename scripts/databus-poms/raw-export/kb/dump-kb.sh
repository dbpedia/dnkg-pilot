#SPARQL_ENDPOINT=http://data.bibliotheken.nl/sparql  SPARQL_GRAPH="http://data.bibliotheken.nl/thesp/"  FILE_NAME_PREFIX="kb_partition=thesp_set=thes" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
#SPARQL_ENDPOINT=http://data.bibliotheken.nl/sparql  SPARQL_GRAPH="http://data.bibliotheken.nl/thesc/"  FILE_NAME_PREFIX="kb_partition=thesc_set=thes" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
#SPARQL_ENDPOINT=http://data.bibliotheken.nl/sparql  SPARQL_GRAPH="http://data.bibliotheken.nl/thes/"  FILE_NAME_PREFIX="kb_partition=thes_set=thes" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
for f in dumps/kb*thes.nt; do
	lbzip2 $f
done
