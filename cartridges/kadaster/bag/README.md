# Overview of the BAG → DBpedia transformation

This is a simple overview to ensure that mappings from BAG to DBpedia
are consistent throughout the various `construct` queries in this
directory.

```
bag:OpenbareRuimte → dbo:RouteOfTransportation
bag:Pand → dbo:Building
bag:bijbehorendeWoonplaats/bag:naamWoonplaats → dbo:place
bag:identificatiecode → dbo:id
bag:naamOpenbareRuimte → dbo:name
bag:status/skos:definition → dbo:status
dbo:address
bag:pandrelatering^/bag:hoofdadres/bag:bijbehorendeOpenbareRuimte/bag:naamWoonplaats → dbo:place
bag:pandrelatering^/bag:hoofdadres/bag:postcode → dbo:postalCode
```
