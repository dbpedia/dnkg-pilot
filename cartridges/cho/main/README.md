# notes
- looked at https://linkeddata.cultureelerfgoed.nl/sparqlviewer
- limit is 15000
- received timeout of http proxy
- encoding query and sending to https://linkeddata.cultureelerfgoed.nl/sparql?query=  works
https://linkeddata.cultureelerfgoed.nl/sparql?query=PREFIX%20rdf%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0APREFIX%20rdfs%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0ASELECT%20distinct%20%3Fg%20WHERE%20%7B%0A%20%20graph%20%3Fg%20%7B%3Fsub%20%3Fpred%20%3Fobj%7D%20.%0A%7D%20%0ALIMIT%20100
- three graphs: 

	<uri>https://linkeddata.cultureelerfgoed.nl/def/ceo</uri>
				<uri>https://linkeddata.cultureelerfgoed.nl/id/ceo/</uri>
				<uri>https://data.cultureelerfgoed.nl/term/id/cht/thesaurus</uri>

- 63331   ?s a <https://linkeddata.cultureelerfgoed.nl/def/ceo#Rijksmonument> .




PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
SELECT  (count(?s) as ?instancecount ) ?c WHERE {
  ?s a ?c .
} GROUP BY ?c
ORDER by DESC(?instancecount) 


instancecount 	class
1769662	https://linkeddata.cultureelerfgoed.nl/def/ceo#Datering 
1769662	https://linkeddata.cultureelerfgoed.nl/def/ceo#Tijdvak 
1440639	https://linkeddata.cultureelerfgoed.nl/def/ceo#Omschrijving 
1346767	https://linkeddata.cultureelerfgoed.nl/def/ceo#Samenhang 
884830	https://linkeddata.cultureelerfgoed.nl/def/ceo#Gebeurtenis 
862938	https://linkeddata.cultureelerfgoed.nl/def/ceo#Type 
404559	https://linkeddata.cultureelerfgoed.nl/def/ceo#ArcheologischComplex 
402275	https://linkeddata.cultureelerfgoed.nl/def/ceo#StijlEnCultuur 
388648	https://linkeddata.cultureelerfgoed.nl/def/ceo#Materiaal 
380059	https://linkeddata.cultureelerfgoed.nl/def/ceo#Vondsten 
303816	https://linkeddata.cultureelerfgoed.nl/def/ceo#Adresgegevens 
219957	https://linkeddata.cultureelerfgoed.nl/def/ceo#LocatieAanduiding 
213452	https://linkeddata.cultureelerfgoed.nl/def/ceo#Geometrie 
187423	https://linkeddata.cultureelerfgoed.nl/def/ceo#ArcheologischOnderzoeksgebied 
108088	https://linkeddata.cultureelerfgoed.nl/def/ceo#BRKRelatie 
99951	https://linkeddata.cultureelerfgoed.nl/def/ceo#Vondstlocatie 
75430	https://linkeddata.cultureelerfgoed.nl/def/ceo#Functie 
67340	https://linkeddata.cultureelerfgoed.nl/def/ceo#Grondsporen 
67010	https://linkeddata.cultureelerfgoed.nl/def/ceo#BasisregistratieRelatie 
63331	https://linkeddata.cultureelerfgoed.nl/def/ceo#Rijksmonument 
39527	http://www.w3.org/2004/02/skos/core#Concept 
22768	https://data.cultureelerfgoed.nl/vocab/id/cht#CHTconcept 
13024	https://linkeddata.cultureelerfgoed.nl/def/ceo#ArcheologischTerrein 
12639	https://linkeddata.cultureelerfgoed.nl/def/ceo#Naam 
11581	https://linkeddata.cultureelerfgoed.nl/def/ceo#ActorEnRol 
9178	https://linkeddata.cultureelerfgoed.nl/def/ceo#BouwkundigeKwaliteit 
6153	https://linkeddata.cultureelerfgoed.nl/def/ceo#BAGRelatie 
2834	https://linkeddata.cultureelerfgoed.nl/def/ceo#Complex 
1032	https://data.cultureelerfgoed.nl/vocab/id/cht#Fysiek-kenmerk 
476	https://linkeddata.cultureelerfgoed.nl/def/ceo#Gezicht 
355	http://standaarden.overheid.nl/owms/terms#Gemeente 
229	https://data.cultureelerfgoed.nl/vocab/id/rce#Source 
91	http://www.w3.org/2002/07/owl#ObjectProperty 
75	http://www.w3.org/2002/07/owl#DatatypeProperty 
34	http://www.w3.org/2002/07/owl#Class 
31	https://data.cultureelerfgoed.nl/vocab/id/rce#SourceHolder 
18	https://linkeddata.cultureelerfgoed.nl/def/ceo#Werelderfgoed 
15	http://schema.semantic-web.at/skos/1.0/extension/OrderDefinition 
12	http://standaarden.overheid.nl/owms/terms#Provincie 
10	https://data.cultureelerfgoed.nl/vocab/id/cht#ObjectTypeCategory 
5	https://data.cultureelerfgoed.nl/vocab/id/rce#ConceptStatus 
3	http://purl.org/dc/terms/Agent 
2	http://www.w3.org/2004/02/skos/core#ConceptScheme 
1	http://rdfs.org/ns/void#Dataset 
1	http://schema.semantic-web.at/skos/1.0/extension/OrderedCollection 
1	http://www.w3.org/2000/01/rdf-schema#Class 
1	http://www.w3.org/2000/01/rdf-schema#Datatype 
1	http://www.w3.org/2002/07/owl#Ontology 
1	http://www.w3.org/ns/dcat#Dataset 




PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
SELECT * WHERE {
 ?a ?b  <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/bagrelatie/18348> . 
 <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/bagrelatie/18348> ?p ?o .
} 


a 	b 	p 	o 
https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/basisregistratierelatie/16628 	https://linkeddata.cultureelerfgoed.nl/def/ceo#heeftBAGRelatie 	http://www.w3.org/1999/02/22-rdf-syntax-ns#type 	https://linkeddata.cultureelerfgoed.nl/def/ceo#BAGRelatie 
https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/basisregistratierelatie/16628 	https://linkeddata.cultureelerfgoed.nl/def/ceo#heeftBAGRelatie 	https://linkeddata.cultureelerfgoed.nl/def/ceo#BAGRelatienummer 	18348
https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/basisregistratierelatie/16628 	https://linkeddata.cultureelerfgoed.nl/def/ceo#heeftBAGRelatie 	https://linkeddata.cultureelerfgoed.nl/def/ceo#pandIdentificatie 	654100000003531
https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/basisregistratierelatie/16628 	https://linkeddata.cultureelerfgoed.nl/def/ceo#heeftBAGRelatie 	https://linkeddata.cultureelerfgoed.nl/def/ceo#verblijfsobjectIdentificatie 	654010000001819


