for f in 2020.08.08/kb_partition\=*\=facts.nt.bz2 ; do
	#new_name=$(echo ${f##*/} | sed 's,=facts,=types,')
	new_name=$(echo ${f} | sed 's,=facts,=types,')
	lbzcat $f | grep http://www.w3.org/1999/02/22-rdf-syntax-ns\#type | lbzip2 -c > $new_name
done
