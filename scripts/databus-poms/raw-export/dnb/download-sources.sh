mkdir -p dnb-downloads/$1/
cd dnb-downloads/$1/
wget https://data.dnb.de/opendata/authorities-geografikum_lds.ttl.gz
wget https://data.dnb.de/opendata/authorities-koerperschaft_lds.ttl.gz
wget https://data.dnb.de/opendata/authorities-kongress_lds.ttl.gz
wget https://data.dnb.de/opendata/authorities-name_lds.ttl.gz
wget https://data.dnb.de/opendata/authorities-person_lds.ttl.gz
wget https://data.dnb.de/opendata/authorities-sachbegriff_lds.ttl.gz
wget https://data.dnb.de/opendata/authorities-werk_lds.ttl.gz
