SPARQL_ENDPOINT="https://linkeddata.cultureelerfgoed.nl/sparql"  SPARQL_GRAPH="https://linkeddata.cultureelerfgoed.nl/id/ceo/"  FILE_NAME_PREFIX="cho_partition=ceo_set=main" SPARQL_BATCHSIZE=15000 mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
for f in dumps/cho*.nt; do
	lbzip2 $f
done
