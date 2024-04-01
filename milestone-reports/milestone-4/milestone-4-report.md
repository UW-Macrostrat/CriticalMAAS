# Report period

This **Milestone 4** report describes the the technical progress of the
UW–Madison – Macrostrat team on the CriticalMAAS project, from February 23–March
29 (Month 7). It builds on the research and technical objectives reported in our
[Phase 1 Research Plan][phase1_plan] and developments since submitting our
[Milestone 3 report][milestone_3_report] in late February 2024.

# Code and documentation

The primary deliverable for CriticalMAAS Milestone 4 is a second release of code
and documentation covering Macrostrat's contribution to CriticalMAAS. These
components are indexed in the [**UW–Macrostrat CriticalMAAS README**][readme] at
the root of the the [`UW-Macrostrat/CriticalMAAS`][gh:criticalmaas] GitHub
repository.

Macrostrat is a multi-faceted system, and building new functionality for
CriticalMAAS involves many codebases, which are summarized below. Documentation
is available at
[Macrostrat documentation website](https://dev2.macrostrat.org/docs) (_in early
development_) and in each repository's `README.md` file.

## Macrostrat core system

A modular Macrostrat system, the key code deliverable of Macrostrat's
CriticalMAAS work, is housed in the [`UW-Macrostrat/macrostrat`][gh:macrostrat]
repository. This codebase includes Macrostrat's database schema, management
scripts, control framework, and ingestion pipeline. Several other repositories
contain important elements of the Macrostrat system, including:

- [`UW-Macrostrat/macrostrat-api`](https://github.com/UW-Macrostrat/macrostrat-api):
  Macrostrat's current (v1-2) API, which provides access to Macrostrat's web
  services for current functionality
- [`UW-Macrostrat/tileserver`](https://github.com/UW-Macrostrat/tileserver):
  Server for vector and raster tiles to GIS software and TA3 performers
- [`UW-Macrostrat/api-v3`](https://github.com/UW-Macrostrat/api-v3):
  Macrostrat's v3 API, which will be the primary API for new capabilities,
  including CriticalMAAS
- [`UW-Macrostrat/python-libraries`](https://github.com/UW-Macrostrat/python-libraries):
  Shared Python libraries for database access and application management.
- [`UW-Macrostrat/web`](https://github.com/UW-Macrostrat/web): Macrostrat's main
  web interface codebase
- [`UW-Macrostrat/web-components`](https://github.com/UW-Macrostrat/web-components):
  Shared React/Typescript components for geological user interfaces

## Geologic metadata curation

Several codebases are being developed to curate rock-record descriptions from
the geological literature through relationship extraction and named entity
resolution atop the [xDD](https://xdd.wisc.edu/) platform. Some of these predate
CriticalMAAS but are being evaluated to drive program functionality.

- [`UW-Macrostrat/unsupervised-kg`](https://github.com/UW-Macrostrat/unsupervised-kg):
  Unsupervised knowledge graph construction to discover new entities and
  relationships from geological literature.
- [`UW-Macrostrat/llm-kg-generator`](https://github.com/UW-Macrostrat/llm-kg-generator):
  LLM-assisted graph generation to extracts geological facts, operating over the
  scientific literature to characterize batches of geologic names.
- [`UW-xDD/text2graph_llm`](https://github.com/UW-xDD/text2graph_llm): A tool to
  transform textual data into structured graph representations, using LLMs to
  identify and extract relationships between locations and geological entities
  from text.
- [`UW-Madison-DSI/ask-xDD`](https://github.com/UW-Madison-DSI/ask-xDD): A chat
  interface and API endpoint for accessing academic information via
  Retrieval-Augmented Generation (RAG). The
  [prototype](http://cosmos0001.chtc.wisc.edu:8501/) currently covers topics
  such as geoscience, climate change, and COVID-19.

Work is just beginning to integrate these tools into an infrastructure for bulk
extraction of geologic information, which will be housed at
[`UW-Macrostrat/macrostrat-xdd`](https://github.com/UW-Macrostrat/macrostrat-xdd).

### Geologic map editing

A prototype human-in-the-loop (HITL) geologic map editing system is being
developed in several repositories:

- [`Mapboard/topology-manager`](https://github.com/Mapboard/topology-manager): a
  topological map manager for geologic maps stored in PostGIS.
- [`Mapboard/Mapboard-Platform`](https://github.com/Mapboard/Mapboard-Platform):
  a web infrastructure to support map editing.

Both of these are Apache 2.0 licensed and rely on Macrostrat's [Python
libraries][gh:python_libraries].

The map editing system is augmented by natural editing capabilities provided by
the [**Mapboard GIS**](https://mapboard-gis.app) iPad app and server components.
These capabilities can be integrated with the CriticalMAAS system to speed
editing, but they **are not available under an open-source license**.
Alternative editing approaches such as direct connection to standard GIS
platforms (particularly QGIS) will be available, and simplified editing APIs can
be integrated if desired by DARPA or USGS.

### Program coordination

Macrostrat has contributed code for shared infrastructure for the CriticalMAAS
program, including data formats, schemas, and shared libraries.

- [`DARPA-CriticalMAAS/ta1-geopackage`](https://github.com/DARPA-CRITICALMAAS/ta1-geopackage):
  A GeoPackage-based data format for validating and storing TA1 output. It is
  unclear if this will be used in the final system, but it was created to
  support the program before the CDR took on the responsibility of data storage
  and schema conformance.
- [`DARPA-CriticalMAAS/schemas`](https://github.com/DARPA-CRITICALMAAS/schemas):
  A repository for schemas and data formats for TA1-3 integrations (_started by
  UW–Macrostrat and subsequently contributed to by all TA teams_)
- [`UW-xDD/document-store`](https://github.com/UW-xDD/document-store): A
  supplemental store for public/user provided PDFs that provides full-text
  access, integrates with xDD APIs. **Note: This repository is being integrated
  into the CDR codebase.**

# Technical accomplishments

## Macrostrat core system

Significant progress has been made on consolidating Macrostrat's core system
into a more declarative and unified framework. Key accomplishments include

- **All Macrostrat core codebases are now publicly available under the _Apache
  2.0_ license.** This is a major milestone in our fulfillment of the
  CriticalMAAS requirements for a system deliverable to USGS.
- Macrostrat's control framework has been considerably improved in this code
  release, with a `macrostrat` command line interface with subcommands for
  database management and map ingestion.
- Automated test suites and CI pipelines have been added to key components such
  as [Macrostrat Python libraries][gh:python_libraries] and the [v3
  API][gh:macrostrat_api_v3] to ensure stable capabilities. Such tests will be
  added to other components in the coming months.
- Most Macrostrat services have been containerized for local or cloud
  deployment, with CD processes that track both the `main` branch and tagged
  releases.

Work is ongoing to fully document the Macrostrat codebase, system design,
capabilities, and usage. A new documentation website available at
[dev2.macrostrat.org/docs](https://dev2.macrostrat.org/docs) to centralize these
resources. This site is still in early development, but its early form links to
resources such as API documentation (OpenAPI-compatible for new APIs), example
user interfaces, and documentation for shared [Python][gh:python_libraries] and
[web component][gh:web_components] libraries. The CriticalMAAS-specific
entrypoint into the documentation, the [**UW–Macrostrat CriticalMAAS
README**][readme], has been updated with links into specific parts of this
documentation footprint.

Most of the technical pieces are in place to run a fully functional standalone
deployment from `macrostrat up`. Several major missing elements are the focus of
current development:

- The system requires an existing Macrostrat database dump with at least some
  data pre-filled (especially data dictionaries). One key problem that some data
  models refer to vocabulary elements by their integer primary key, which makes
  portability between Macrostrat instances challenging. This issue is already
  being encountered between Macrostrat's development and production databases,
  underscoring the need for a solution.
- [Macrostrat's legacy API][gh:macrostrat_api] (v1-2) still maintains a
  dependency on MariaDB for some data routes. The PostGIS database that forms
  the core of Macrostrat's streamlined implementation contains all data, but
  work is needed to port queries and ensure that the new API does not break
  existing functionality. We are currently reworking the API's testing framework
  (which has been inoperative for several years) and will use that to ensure
  conformance and compatibility.

Our goal is for a standalone deployment of Macrostrat including these elements
to be possible by soon after the 9-Month Hackathon, to establish a
well-documented and tested process by the end of the program.

### Map ingestion pipeline

Progress on the since Milestone 3 has been primarily focused on consolidating
the map ingestion pipeline to be more adaptable and flexible, in response to
workflow deficiencies identified at the 6-month Hackathon. We've significantly
refined the command-line interface to allow maps to be staged, prepared, and
finalized using a unified interface. Several issues limiting the functionality
of legend curation tools have been resolved, and the legend preparation web
interface has been implemented for points and lines (initial development focused
on map polygons). Additionally, a new metadata management interface is being
developed to allow the progress of maps through the ingestion pipeline to be
tracked and managed. This interface will streamline the curation of large
numbers of maps and allow for the easy identification of maps that require
additional attention [@sec:vector-map-access]. A key target is to have this tool
ready for USGS evaluation and testing by the 9-month Hackathon.

### Provider-side filtering of geologic maps for TA3

One of the major gaps identified at the 6-month Hackathon was the lack of
server-side capabilities to filter Macrostrat's vector tiles. This gap was a
result of TA3's expected usage pattern changing substantially to a
server-side-filtering approach, which was not anticipated as being a key need
based on [_Lawley et al., 2023_][lawley2023] modeling approaches. We have made
substantial progress on scoping and designing this feature, and will implement
it prior to the 9-month Hackathon. This new feature will be developed alongside
the standardization of a CI/CD pipeline for the [Macrostrat
tileserver][gh:tileserver] codebase, bringing it into line with our other
services.

#### Filter query language

Open-ended filtering is difficult functionality to implement in Macrostrat's API
due to the number and heterogeneity of data fields and the prospect of complex
queries across different regions and maps. We are hoping to implement this
functionality using the semantics of an existing query language to improve
usability and clarity. We are currently evaluating the potential of several
query languages to drive API filtering. These include

- Direct specification of a WHERE clause as a query parameter. This approach is
  similar to that used by the
  [ArcGIS Online](https://developers.arcgis.com/javascript/latest/tutorials/filter-a-feature-layer-with-sql/)
  platform but will be difficult to document. The encoding of spatial operators
  may also be challenging.
- [PostgREST](https://postgrest.org/en/v12/references/api/tables_views.html#operators)-style
  filtering, which faithfully exposes the filtering capabilities of PostgreSQL
  in a small number of query parameters. However, it
  [does not support spatial operators](https://github.com/PostgREST/postgrest/issues/223),
  which are difficult to forgo for the CriticalMAAS use case.
- "Common Query Language" (CQL) filtering, which is a standard for querying
  geospatial data in development by the Open Geospatial Consortium (OGC). We are
  evaluating the [pygeofilter](https://github.com/geopython/pygeofilter) library
  to help implement this functionality.

Overall, the balance of usability, expressiveness, and documentation suggest
that the CQL approach is the most promising. This will be the focus of our
prototyping going forward.

#### Expression of lithological queries

One other usability gap we are working to address is how Macrostrat's lithology
dictionaries are exposed for API querying. Macrostrat hosts tree-based
[lithology taxonomy](https://dev2.macrostrat.org/api/v2/defs/lithologies) that
is similar (and conformant to) existing dictionaries such as the
[USGS lithologic classification](https://apps.usgs.gov/thesaurus/thesaurus-full.php?thcode=4)
and the State Geologic Map Compilation lithologic hierarchy. We track rock types
in a four-level, denormalized tree, `lith -> group -> type -> class`. For
instance,  
[https://dev2.macrostrat.org/api/v2/defs/lithologies?lith=basalt](https://dev2.macrostrat.org/api/v2/defs/lithologies?lith=basalt)  
yields  
`basalt -> mafic -> volcanic -> igneous`. This taxonomy can be accessed in the
Macrostrat API and web application.

Unfortunately, querying this tree in Macrostrat's current API is somewhat
awkward, requiring separate queries at each level of the hierarchy. For
instance, you must know a priori that `mafic` is a `lith_group` and query as
such,
[`../lithologies?lith_group=mafic`](https://dev2.macrostrat.org/api/v2/defs/lithologies?lith_group=mafic).
[`../lithologies?lith=mafic`](https://dev2.macrostrat.org/api/v2/defs/lithologies?lith=mafic)
would return a different, more restricted set of results, missing terms
encompassed in the `mafic` group like basalt. This makes it difficult to
construct expressive queries. As part of designing tileserver filtering, we are
hoping to improve this situation by allowing queries expressed in terms of a
single lithology to be automatically expanded to include all child terms.

- A query for `lith=volcanic` would automatically include `rhyolite`, `basalt`,
  and other extrusive igneous rocks.
- The ability to return exact matches will be preserved with a `lith:exact`
  parameter.

This will make it easier to construct complex lithological queries and preserve
the option to add new levels to the lithology hierarchy in the future.

## Geologic metadata curation

### KGG approach

![KGG pipeline](./images/kgg-pipeline.png)

### LLM-assisted relationship extraction

- Extract entities using LLM (5000 docs for testing)
  - Strat name (n=4151)
  - Lithology (n=7123)
  - Location (n=10618)
- Get known entities from Macrostrat
  - Strat name (n=47821)
  - Lithology (n=212)
- Obtain semantic embeddings
- Get the closest known entity for each LLM extracted entity within the same
  category (local), and across all categories (global)

1. Identify and extract entities from the text using an exact match approach
   against a Macrostrat known entities.
2. Include the details of these identified entities in the input prompt,
   instructing the language model to consider these entities while determining
   relationships.
3. Extract relationship triplets from the LLM on the enriched prompt.
4. Refine the extracted entities by comparing their semantic similarity to the
   Macrostrat known entities, accepting matches with a similarity score above
   0.95. Override category if needed.
5. Incorporate detailed information from the Macrostrat database for the known
   entities into the final relationship triplets.

## Geologic map editing

We have demonstrated prototype functionality for editing geologic maps at the
Month 3 and 6 hackathons. Our approach is based on the
[`Mapboard/topology-manager`][gh:topology-manager] package and the [**Mapboard
GIS**][mapboard-gis] iPad app. We have made great progress in bringing this
capability to bear on CriticalMAAS data.

# Issues and Concerns

## Macrostrat core system

Consolidating Macrostrat's core system is going well, but a few small issues
will be encountered in the coming months:

## Accessing vector maps {#sec:vector-map-access}

Carried over from our Milestone 3 report

We had discussed at the Month 6 hackathon the possibility of engaging with
Jataware to use their web scraping system to find and stage vector maps
(possibly using the CDR as a indexing system). This would be a significant
improvement over current practices, which require manually finding and staging
maps or writing our own web-scraping scripts that retread similar ground to
Jataware's exercise for raster maps. We have not yet engaged in detail with
Jataware to plan or build this capability, as they are busy building the CDR.

Even better would be to work with USGS to get access to their vector map
collection, which is maintained internally by NGMDB and contains a large number
of maps in relatively "clean" data formats amenable to harmonization in
Macrostrat's framework. However, this is apparently not possible due to
organizational barriers within USGS. Given that vector mapping compiled from the
1990s onwards tends to be the "best" data where available, CriticalMAAS is at a
significant disadvantage for being unable to access this resource. Some
high-level attention to this problem between DARPA and the USGS divisional
leadership would be beneficial to ensuring that the program can deliver its full
suite of capabilities.

## "Structurally complete" maps

- Our TA1 Geopackage has been rendered largely obsolete. This was potentially a
  waste of time. But it also points to a more troubling issue in the program: a
  lack of a clear plan to get to fully formed geologic map products.
- USGS participants seem to want to preserve optionality as much as possible for
  the final analysts doing a mineral assessment. While we defer to this
  strategy, as they are the intended users,

[gh:criticalmaas]: https://github.com/UW-Macrostrat/CriticalMAAS
[gh:macrostrat]: https://github.com/UW-Macrostrat/macrostrat
[ta1-geopackage]: https://github.com/DARPA-CRITICALMAAS/ta1-geopackage
[document-store]: https://github.com/UW-xDD/document-store
[cosmos]: https://github.com/UW-COSMOS/COSMOS
[gh:topology-manager]: https://github.com/Mapboard/topology-manager
[gh:python_libraries]: https://github.com/UW-Macrostrat/python-libraries
[gh:web_components]: https://github.com/UW-Macrostrat/web-components
[mapboard-gis]: https://mapboard-gis.app
[phase1_plan]:
  https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2023-10-CriticalMAAS-Phase-1-research-plan.pdf
[milestone_3_report]:
  https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2024-02-CriticalMAAS-Milestone-3-report.pdf
[readme]: https://github.com/UW-Macrostrat/CriticalMAAS/blob/main/README.md
[gh:macrostrat_api]: https://github.com/UW-Macrostrat/macrostrat-api
[gh:macrostrat_api_v3]: https://github.com/UW-Macrostrat/api-v3
[gh:tileserver]: https://github.com/UW-Macrostrat/tileserver
[lawley2023]: https://doi.org/10.1007/s11053-023-10216-1
