SPARQL_ENDPOINT="http://data.bibliotheken.nl/sparql"  SPARQL_GRAPH="http://data.bibliotheken.nl/dbnla/"  FILE_NAME_PREFIX="dbnl_partition=dbnla_set=main" mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
for f in dumps/dbnl*.nt; do
	lbzip2 $f
done
