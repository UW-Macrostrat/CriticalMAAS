# Introduction
The primary objective of our TA4 activities is to adapt and leveage the Macrostrat and xDD data systems for the CriticalMAAS workflow. This places emphasis on the geological data that are central to TA3 modelling pipeline. Our specific immediate objectives are to 1) build a geological map ingestion and harmonization system for TA1 output that can rapidly augment the more than 300 geological maps that are already available in Macrostrat and tailoring the map data access points (APIs and tile servers) to conform with TA3 requirements, and 2) establishing an xDD corpus and document annotation and distribution pipeline that can faciliate TA2 data extraction tasks. We are attempting to facilitate integration of TA1 and some of TA2 outputs by focusing on geological units that appear in maps, geologic columns, and the literature, the goal being to augument map/column units with additional geological data that can be used in modelling steps. This initial thrust is, therefore, largely focused on integrating data extraction and assimilation pipelines that are directed towards TA3. Human-in-the-loop interfaces for assessing, annotating, and editing the data from TA1 and TA2 will be developed as the data flow pipelines are established. Here we report on our Phase 1 research plan to accomplish these objectives.

## Success criteria for Macrostrat TA4 system

- Can we provide the data produced by TA1 and TA2 to TA3 (and other TA4 performers), on demand and en masse?
- Can we augment and standardize these datasets to provide relevant geological information, particularly lithology and its properties?

## System goals

Feed TA2 data to TA3

- Make mine report data sub-settable by geologic formation, lithology, etc.
  through linking to TA1 output (and geologic mapping from other sources)
- Provide these point data objects using standardized APIs that can be queried
  and assimilated in TA3 modeling

## Adjustments in response to project integration

We have adapted our approach somewhat in light of initial integrations with
other performers and discussions with other TAs. Key new things we would like to
emphasize:

We will plan to integrate with tools produced by other TA4 performers:

- Jataware will produce some end-to-end solutions particularly for
  georeferencing and page-level evaluation of map data objects.
- MTRI will work with TA4 to ensure that geologic mapping data can be filtered
  and subset

Based on descriptions of bottlenecks in CMA process workflows described by
Lawley, and the expected structure of TA1 and TA2 outputs, we forecast that a
major problem will be assembing a geologic dataset that is sufficiently well-characterized and
standardized to be useful across scales and study areas to extract fairly
specific CMA-relevant information. Given this expected challenge, we will devote
extra effort to internally characterizing and harmonizing geologic map units, in
order to provide appropriately queryable TA1 and TA2 datasets.

# Software development plan

Our software development plan will prioritize aggregating TA1-2 data to support
TA3 workflows, providing geologic data in appropriate formats for CMA, and
augmenting the attributes of geologic data to form harmonized, multiscale
products that support CMA workflows. As part of these efforts, we will build
data-providing infrastructure, APIs, and user-facing human in the loop (HITL)
interfaces.

Our software development plan will be organized around three general lines:

1. Provide geologic datasets to CriticalMAAS performers
2. Build a system for geologic map integration
3. Characterize and link geologic entities
4. Build HITL interfaces

This is broadly similar to the Tasks 1-3 proposed in our initial proposal, but
with "linking geologic entities" extracted to a top-level task to align with our
new understanding of its critical importance in the contextx of this project.

## Providing geologic datasets for CriticalMAAS performers

Our key task for supporting CriticalMAAS is to provide harmonized geologic
datasets over stable APIs to other CriticalMAAS performers. The most critical
task is to provide these datasets to TA3, but we will also provide them to TA1
and TA2 to support feedback. Additionally, we will support the activities and
HITL interfaces of other TA4 performers with stable APIs (e.g., for geologic and
raster data tiles) atop shared TA4 data repositories.

### Geologic map data

Tiled Macrostrat output, API-available in vector-based tile format has gained
agreement from MTRI (TA4) and SRI (TA3) that it has the requisite structure and
properties to be used as a base for CMA workflows. We will continue to refine
this output and provide it to TA3. We will work on:

- improving the structure of tileserver output to better support querying by TA3
  (ex., adding ability to filter by lithology).
- Improving API capabilities for querying and filtering by relevant data fields
- Integrating attribute types discussed by Lawley et al. (2022) and others, such
  as age ranges, paleolatitude, and vetted lithologic classes.

The key codebase for this work, as well as for raster data provision, is the
[UW-Macrostrat/tileserver](https://github.com/UW-Macrostrat/tileserver)
repository.

<div id="fig:macrostrat-tile-api">
![Tiled Macrostrat output for provision to TA3](img/tiled-macrostrat-output.png){width=40%}
![Attributed Macrostrat map in QGIS](img/macrostrat-map-qgis.png){width=40%}

Macrostrat's tiled output API, for provision to TA3

</div>

### Mineral site data

We have successfully validated serving and filtering of point datasets relevant
to CMA, including the MRDS dataset. Approaches to curating point data and
linking it closely to geologic context (enabling spatial and geological
time/unit filtering)

Mine sites synthesized from TA2 will be linked to geologic context and forwarded
to TA3 and TA4 HITL interfaces (ex., MTRI and/or EIS QGIS plugins).

![Macrostrat MRDS data layer, showing basic capabilities for point data provision](img/macrostrat-mrds-interface.png){width=40%}

<!-- https://staging.v2.macrostrat.org/map/dev/weaver -->

Macrostrat maintains links to other point datasets that may be useful to forward
to TA3, such as USGS geochemical databases. If more datasets are needed, we will
work with TA3 to identify and integrate them into the system, which will make them readily avaiable on demand for modelling tasks.

### Raster datasets

Raster datasets can usually be easily integrated directly into the workflow of TA3. However,
compositing raster datasets across scales, etc. presents demanding workflows
that can potentially be supported by TA4. We have validated and will maintain
key capabilities to store and serve raster datasets, to support map feedback and
CMA workflows.

- [Macrostrat Raster CLI](https://github.com/UW-Macrostrat/raster-cli)

This can also be used to help support TA1 feedback

### A system to orchestrate geological data

The core of the Macrostrat system consists of the databases and infrastructure
that hosts the above data capabilities. In order to maintain and extend these
APIs and data-provision systems, we will invest in the design and structure
of underlying Macrostrat systems.

- [Macrostrat CLI](https://github.com/UW-Macrostrat/cli)
- [Macrostrat infrastructure configuration](https://github.com/UW-Macrostrat/tiger-macrostrat-config)

#### Hackathon targets

- _Month 3 hackathon_: Containerized Macrostrat system that supports basic
  capabilities
- _Month 6 hackathon_: Data model adjustments and pipelines for storing new data
  and annotations
- _Base evaluation_: End-to-end system for storing and distributing geological
  data and literature artifacts

## Geologic map integration pipeline

As a first step towards HITL interfaces to standardize geological map
information (e.g., legend data, line types, etc.) from TA1 outputs, we're going
to try to improve the speed and interactivity of Macrostrat's vector data
ingestion pipeline. This system moves from heterogeneous inputs, like
Geodatabases, Shapefiles, or the old ArcInfo files referenced, to the
standardized layers that drive Macrostrat APIs.

Geologic map ingestion is reliant both on GIS data manipulation (and in the case
of TA1 performers, image analysis), and on geological expertise. Geological
decisions include splitting up unit ages from stratigraphic names, descriptions,
and lithological information in legend text, which must in many cases must be done
manually. It's obviously useful to allow the geologic expertise to be applied
without the need for SQL manipulation, as that will allow geologists to more
readily participate.

We will build a web-based interface to allow geologists to interactively
manipulate map data, and to provide feedback on the quality of the map data.
This will operate over:

- Vector datasets in general (for assimilating already digitally-published
  mapping and TA1 outputs for representation in Macrostrat)
- paired vector/raster map datasets (to facilitate training by TA1)

### Relevant software repositories

- [Macrostrat CLI](https://github.com/UW-Macrostrat/cli) holds processing
  interfaces
- [Map integration system](https://github.com/UW-Macrostrat/map-integration)
  will hold map ingestion/harmonization web app
- [Python libraries](https://github.com/UW-Macrostrat/python-libraries):
  monorepo for Python libraries used across projects

### Milestones

- Initial demo: Month 3 hackathon

## Geologic entity characterization pipeline

- Macrostrat maintains a database of geologic entities, which can be used to
  further characterize geologic maps

However, this is not of adequate quality to support CMA workflows. This will be
rectified by a combination of leveraging outputs from TA1-2, augmenting it with
our own AI-assisted literature synthesis, and building new HITL interfaces for
characterizing rock units.

Two separate approaches:

1. Find new descriptors of existing entities
2. Find new entities not currently tracked in the database

This will help correct several deficiencies of Macrostrat's current
representation of geologic units:

- Lack of information about non-sedimentary units
- Lack of specificity about unit properties

![*(a)* Starting user interface and *(b)* potential additional extractions for CMA-focused entity canonicalization tasks](img/entity-canonicalization.png)

_Geologic units in Macrostrat have curated properties, but these are often not
rigorous or descriptive enough to provide the level of detail needed for CMA
workflows._

## HITL interfaces for TA1-2 pipeline support

Our plan is to produce key HITL interfaces, especially to support TA1 and TA2.

We will also account integrate with feedback interfaces produced by Jataware and
MTRI. In particular, Jataware's map-projection system will be a critical
precursor to our map ingestion system, and MTRIs QGIS plugin will be a key
interface through which TA3 manipulates our vector-tile geologic mapping
outputs.

### Map feedback interfaces

![Map interface showing both vector and raster datasets for the same geologic 
  map, in an interface with synthesized legend information](img/paired-vector-raster.png){#fig:paired-vector-raster
width=70%}

- [Macrostrat web](https://github.com/UW-Macrostrat/web)
- [Macrostrat web components](https://github.com/UW-Macrostrat/web-components)

### Map editing

- [Mapboard topology](https://github.com/Mapboard/topology-manager)

<div id="fig:mapboard-postgis">
![*Mapboard GIS* map interface, an iPad app optimized for drawing geological maps](img/mapboard-interface.jpg){ width=50% }
![Tethered mode for Mapboard Topology manager, which allows topological editing of geologic maps in both standard and purpose-built GIS environments](img/mapboard-postgis.png){
width=40%}

Elements of the Mapboard GIS system for TA1 map correction and feedback.

</div>

### Document-based interfaces

- Coordinate with Jataware for TA2-supporting interfaces
- [COSMOS visualizer](https://github.com/UW-COSMOS/cosmos-visualizer) page-level
  annotation interface may be adapted, or a Jataware-created tool may be used

![COSMOS image tagger user interface, which is an option for adaptation into HITL systems](img/cosmos.png){
width=30% }

## Targets for hackathon events

### Month 3 hackathon

- Import pipeline for geologic maps (TA1 outputs)
  - Feedback mechanism for map legend extractions
- Synthesis of these outputs into TA3-ready products
  - First attempts, showing maps in the right structure but not properly
    attributed

### Month 6 hackathon

- Demonstrated pipeline to accrue descriptive characteristics of rock units from
  literature synthesis
  - Pathway to involve TA2 in providing data to this pipeline
  - Pathway to involve TA3+USGS in providing feedback and HITL effort towards
    synthesizing geologic entities
- Goal: produce "clean" and highly specific lithologic breakdowns of rock
  formations amenable to querying by TA3

### Month 9 hackathon

### Phase 1 Base evaluation

# Current status

## System and interaction design

- Macrostrat team has spearheaded the production of schemas for data interchange
  with TA1-3
- Key additions to the schema: geologic data objects

## Providing literature extractions to TA1 and TA2

The xDD system and COSMOS document extraction pipeline are being used to provide
literature artifacts ready for TA2 extractions, both over USGS documents and the
broader geologic literature.

We are beginning to transition to **GeoKB** as a source of USGS documents. As
part of this transition, we switched from using the USGS Zotero instance as the
primary metadata source for target documents to the GeoKB SPARQL instance, under
the guidance of Sky Bristol. This aligns us with the storage and knowledge plans
of Sky's group at USGS. This includes storing the `w3id` stable URLs, which will
allow us to link directly to the original source for each USGS PDF.

We have created a document set (`criticalmaas`) defined as the union of these
documents with the USGS series publications (doi prefix of `10.3133`). This set
is available within the xDD system and queryable using its API. For instance,
[snippets of documents mentioning the _Bonneterre Dolomite_](https://xdd.wisc.edu/api/snippets?set=criticalmaas&term=Bonneterre%20Dolomite),
a key unit in the Viburnum Trend and type locality of Mississippi Valley-type
ore deposits, can be retrieved. Additionally, we are in the process of running
COSMOS, word2vec, and doc2vec pipelines for the entire set (these are running in
CHTC infrastructure and done to varying degrees of completion). None have live
endpoints yet for the entire `criticalmaas` set (though we have them complete
for the GeoKB-based articles). **These endpoints will be in place by the Month 3
hackathon.**

We will continue to integrate with TA2 to build capabilities around accessing
and manipulating the literature corpus of documents from USGS and other sources.
Since USGS documents are broadly in the public domain, TA2 performers have an
opportunity to follow all extractions back to their full source material; this
is usually encumbered by publisher agreements in the case of other literature
sources, such as Elsevier, Wiley and the like. However, specific information in these source documents can be surfaced and integrated into knowledge bases, provided that the code to locate and extract the information is run within UW's CHTC environment and the output conforms to the expectations of publisher agreements (e.g., extractions constitute a derived data product, such as a list of entities and their relations, and not original unaltered content beyond short snippets of context).

## Progress to initial milestones

We are making progress on all proposed milestones. All but one deliverable
proposed for execution by Month 4 have crossed key thresholds in readiness and
are near completion, except for a single deliverable in Task 3B. The early
establishment of key capabilities allows us to focus on building integrations
with other performers (in all TAs) during and after the Month 3 hackathon.

### Task 1: Supply geological data and literature artifacts to CriticalMAAS TAs 1-3

_Augment and extend Macrostrat and xDD systems to deliver data and artifacts to
TAs 1-3_

#### 1A: Extend Macrostrat for TAs 1-3

_Augment Macrostrat capabilities and datasets with functionality for AI-assisted
critical mineral assessment._

1. **Milestone 2** _(Month 4)_: A containerized instance of Macrostrat: A
   containerized version of Macrostrat is running but not stable, and is being
   used as a base for all development activities
2. **Milestone 2** _(Month 4)_: Database and software capabilities to ingest and
   serve raster datasets: Initial validation complete
3. **Milestone 2** _(Month 4)_: User management and authentication: **In initial
   stages of development, planned by Month 3 hackathon**
4. **Milestone 2** _(Month 4)_: APIs to deliver geologic map and column data to
   TAs1-3: APIs based around existing map and tileserver APIs have been
   partially implemented, and deficiencies in data structure and queryability
   are being identified and evaluated.

#### 1B: Extract literature artifacts using xDD-COSMOS and deliver to TA1-2

_Provide literature artifacts (maps and tables) to TA1-2_

1. **Milestone 1** _(Month 2)_: A vetted corpus of geological literature
   pertinent to mineral assessment: The CriticalMAAS corpus is available
2. **Milestone 2** _(Month 4)_: Pipeline for delivering contextualized
   literature artifacts to TA 1 and 2: COSMOS outputs for maps, table
   extractions, etc. are available

### Task 2: Ingest geological data from TAs 1-3

_Incorporate data products produced by TAs 1-3 into Macrostrat_

#### 2A: Ingest geologic maps from TA1 and link entities

_Incorporate TA1 map data products into harmonized Macrostrat map system_

1. **Milestone 1** _(Month 1)_: Schemas for map data to be accepted by
   Macrostrat system: Done as part of TA4 deliverable
2. **Milestone 2** _(Month 4)_: Documented ingestion APIs for maps from TA1:
   Beginning to produce ingestion CLI and API for TA1 use

#### 2B: Ingest geological data from TA2 and link entities

_Augment and extend Macrostrat map and column unit data to include mineral
assessment-specific criteria_

1. **Milestone 1** _(Month 1)_: Schemas for point-based geological data to be
   accepted by Macrostrat system: Done as part of TA4 deliverable
2. **Milestone 2** _(Month 4)_: Documented APIs for point-based data ingested
   from TA2 (and TA1 as applicable): Started in Weaver repository

### Task 3: Build HITL interfaces for model and extraction improvement

_Build and deploy interfaces to annotate existing and TA- generated data with
expert feedback_

#### Subtask 3A: Annotate and edit geologic maps

_Enable dynamic editing and annotation of geologic maps_

1. **Milestone 2** _(Month 4)_: Add widgets for collecting map candidate
   feedback to Macrostrat’s web map interface: In early development

#### Subtask 3B: Annotate geological data extractions and linked geological entities

_Enable annotation of geological data extracted from descriptive documents_

1. **Milestone 2** _(Month 4)_: Add widgets for collecting linked entity
   feedback in Macrostrat web interfaces: **Not yet addressed**

## Later milestones

We have made some progress to later Phase 1 milestones, as well:

- Subtask 1B **Milestone 4** _(Month 7)_: Pipeline for locating and extracting
  entities and augmenting Macrostrat database: In early exploratory phases with
  CS graduate and undergraduate students supervised by co-PI Venkataraman.
- Subtask 3A **Milestone 4** _(Month 7)_: Adapt Mapboard GIS topological editing
  for map geospatial/topology correction: Key demonstration/validation has been
  accomplished
