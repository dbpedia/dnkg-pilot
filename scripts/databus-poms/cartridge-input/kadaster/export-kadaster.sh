git clone https://github.com/dbpedia/dnkg-pilot
for folder in dnkg-pilot/cartridges/kadaster/bag/* ; do 
  for construct in $folder/*.pt-construct ; do 
	  prop=$(basename $construct .pt-construct)
	  type=$(basename $folder)
	  file=kadaster_set\=bag_partition\=${type}_prop\=$prop
	  if test -f "dumps/$file.nt"; then
		echo "skipping export for $file since it already exists"
	  else
	  	echo "extracting construct to file: $file"
	  	SPARQL_ENDPOINT=http://akswnc7.informatik.uni-leipzig.de:8897/sparql  SPARQL_CONSTRUCT=$(cat $construct) FILE_NAME_PREFIX=$file mvn exec:java -Dexec.mainClass="com.tenforce.etms.Main"
  	  fi
   done  
done 
