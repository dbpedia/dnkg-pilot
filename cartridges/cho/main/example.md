@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix ceo: <https://linkeddata.cultureelerfgoed.nl/def/ceo#> .
@prefix cult: <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/rijksmonument/> .
@prefix purl: <http://purl.org/dc/terms/> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .

<https://data.cultureelerfgoed.nl/term/id/rn/a273be15-311e-4246-b99e-52c2efd97a77>
    a skos:Concept ;
    skos:prefLabel "onbekend" .

<https://data.cultureelerfgoed.nl/term/id/rn/b2d9a59a-fe1e-4552-9a05-3c2acddff864>
    a skos:Concept ;
    skos:prefLabel "rijksmonument" .

<https://data.cultureelerfgoed.nl/term/id/rn/fc966a68-8863-4970-a83e-110f96006c21>
    a skos:Concept ;
    skos:prefLabel "onroerend gebouwd" .

<https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/basisregistratierelatie/16628>
    a ceo:BasisregistratieRelatie ;
    ceo:basisregistratieRelatienummer 16628 ;
    ceo:heeftBAGRelatie <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/bagrelatie/18348> ;
    ceo:heeftBRKRelatie <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/brkrelatie/13893> .

<https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/bagrelatie/18348> a ceo:BAGRelatie;
  ceo:BAGRelatienummer 18348;
  ceo:pandIdentificatie "654100000003531";
  ceo:verblijfsobjectIdentificatie "654010000001819" .


<https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/functie/109196>
    a ceo:Functie ;
    ceo:formeelStandpunt true ;
    ceo:heeftFunctieNaam <https://data.cultureelerfgoed.nl/term/id/rn/95d0669d-a38b-4eac-ba5d-e312a2dd9905> ;
    ceo:hoofdfunctie true ;
    ceo:kennisregistratienummer 109196 ;
    ceo:registratiedatum "1997-09-29"^^xsd:date .

<https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/geometrie/44329>
    <http://www.opengis.net/ont/geosparql#asWKT> "MULTIPOLYGON(((3.82223831783361 51.428445539904,3.82220369557167 51.4284486707061,3.82219618017737 51.4284162038927,3.82223223808491 51.4284130923567,3.82223831783361 51.428445539904)))"^^<http://www.opengis.net/ont/geosparql#wktLiteral> ;
    a ceo:Geometrie ;
    ceo:asWKT-RD "MULTIPOLYGON(((46169.20015 383315.800175,46166.800175 383316.2001,46166.200075 383312.599925,46168.699925 383312.2,46169.20015 383315.800175)))" ;
    ceo:geometrienummer 44329 ;
    ceo:heeftGeometrieKwaliteit <https://data.cultureelerfgoed.nl/term/id/rn/7731e08b-77bc-4eb9-b325-6849a8ea8b19> ;
    ceo:heeftGeometrieStatus <https://data.cultureelerfgoed.nl/term/id/rn/f30ec8d9-bd22-40e1-bf32-026721041e47> .

<https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/locatieaanduiding/13295>
    a ceo:LocatieAanduiding ;
    ceo:heeftLocatieAanduidingStatus <https://data.cultureelerfgoed.nl/term/id/rn/c023fe7d-fc15-459f-8061-091ccbfbfd54> ;
    ceo:heeftLocatieAdres <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/adresgegevens/100502510654> ;
    ceo:locatieAanduidingnummer 13295 .

<https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/omschrijving/235277>
    a ceo:Omschrijving ;
    ceo:formeelStandpunt true ;
    ceo:heeftOmschrijvingstype <https://data.cultureelerfgoed.nl/term/id/rn/0273a12d-7259-4391-aee2-5dac264aebe9> ;
    ceo:kennisregistratienummer 235277 ;
    ceo:omschrijving """Toren Ned. Herv. Kerk. Smalle toren op H-vormige plattegrond.
""" ;
    ceo:registratiedatum "1987-08-25"^^xsd:date .

<https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/rijksmonument/23259>
    a ceo:Rijksmonument ;
    #done
    ceo:heeftBasisregistratieRelatie <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/basisregistratierelatie/16628> ;
    ceo:heeftBebouwdeKomType <https://data.cultureelerfgoed.nl/term/id/rn/a273be15-311e-4246-b99e-52c2efd97a77> ;
    # ~~~~
    ceo:heeftGeometrie <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/geometrie/44329> ;
    ceo:heeftJuridischeStatus <https://data.cultureelerfgoed.nl/term/id/rn/b2d9a59a-fe1e-4552-9a05-3c2acddff864> ;
    ceo:heeftKennisregistratie <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/functie/109196>, <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/omschrijving/235277> ;
    ceo:heeftLocatieAanduiding <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/locatieaanduiding/13295> ;
    ceo:heeftMonumentAard <https://data.cultureelerfgoed.nl/term/id/rn/fc966a68-8863-4970-a83e-110f96006c21> ;
    #done
    ceo:heeftOmschrijving <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/omschrijving/235277> ;
    ceo:heeftOorspronkelijkeFunctie <https://linkeddata.cultureelerfgoed.nl/cho-kennis/id/functie/109196> .

ceo:Rijksmonument
    purl:created "2018-01-30"^^xsd:date ;
    a owl:Class ;
    rdfs:comment "De class Rijksmonument is een representatie van onroerende cultuurhistorische objecten die als rijksmonument zijn aangewezen."@nl ;
    rdfs:label "Rijksmonument"@nl ;
    rdfs:subClassOf ceo:CultuurhistorischObject .

