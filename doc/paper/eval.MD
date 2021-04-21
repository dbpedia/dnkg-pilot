# DNKG Paper Supplements and Reproducibility Overview

## DNKG Infrastructure and Deployed Services 
### Application, Consumer, Debugging Layer

 - DNKG SPARQL https://dnkg.tools.dbpedia.org/sparql
 - Data and Deep Provenance Browser DNKG https://dnkg.tools.dbpedia.org/id/479eR
 - DNKG Global ID Lookup  / ID Translation Service 
	 - https://dnkg.tools.dbpedia.org/idl/479eR
	 - https://dnkg.tools.dbpedia.org/same-thing/lookup/?uri=http://dbpedia.org/resource/Heinrich_Heine
 - DNKG Global Property lookup / Property Translation Service
	 - https://dnkg.tools.dbpedia.org/property/68nE
	 - https://dnkg.tools.dbpedia.org/same-prop/lookup/?uri=http://xmlns.com/foaf/0.1/name 
 - Prototypical Debbuging views:
	 -  RDF DNKG view for Global ID https://dnkg.tools.dbpedia.org/ids/479eR
	 -  Provenance JSON-LD View for Global ID  https://dnkg.tools.dbpedia.org/idp/479eR
 - Mapping Dashboards
	 - https://drive.google.com/drive/folders/10XuQD-LHYN8KQxWKs2bDhuNlrGY814PG?usp=sharing 
 

### Data Management
- All relevant data artifacts are on DNKG Databus user https://databus.dbpedia.org/dnkg/
	- Fused DNKG https://databus.dbpedia.org/dnkg/fusion/dutch-national-kg/
	- Cartridges https://databus.dbpedia.org/dnkg/cartridges/
	- Merged Cartridges / Provenance  https://databus.dbpedia.org/dnkg/cartridges/dutch-national-kg/
- Mapping and Export Definitions https://github.com/dbpedia/dnkg-pilot/tree/master/cartridges
- Collections https://databus.dbpedia.org/dnkg/collections/ 


## Evaluation
 - Cluster and Link Analysis Results with Reproducibility Information (SPARQL queries)
https://docs.google.com/spreadsheets/d/1vyZQoTdRjtXu6yagCKhoXQpKmK92SHcpxHOeuV77TSc/edit#gid=620241974
 - Mapping Pareto Analysis https://drive.google.com/drive/u/0/folders/1ar68Qj2KpHsUaeHFT1hjsnQ1-1ZfmxBy

## Code
 - SPARQL Dumping Code for raw https://github.com/JJ-Author/sparql-dump/
 - Extraction & Transformation 
	 - https://github.com/dbpedia/dnkg-pilot/tree/master/scripts/databus-poms/cartridge-input 
 - Cluster Quality (Person Match) Analysis code
	 - https://github.com/dbpedia/dnkg-pilot/tree/master/scripts/tools
 - FlexiFusion code is not available online, but was privately shared by the FlexiFusion authors for this experiment

