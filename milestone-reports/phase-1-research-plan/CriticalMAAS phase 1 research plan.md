> [!info] Month 2 report, due COB October 13, 2023
>
> This is just a friendly reminder that, per your SOWs, CriticalMAAS Phase 1 research plans for each performer are due at the end of Month 2. Specifically, we would like to request that you submit your reports to the DARPA VAULT, as well as [Erica Briscoe](mailto:erica.briscoe@darpa.mil), [Brian Sandberg](mailto:brian.sandberg.ctr@darpa.mil), [Danielle Royer](mailto:danielle.royer.ctr@darpa.mil), and [Hunter Gabbard](mailto:hunter.gabbard.ctr@darpa.mil) by **COB October 13th**. Instructions for submitting your reports to VAULT are included in the word document attachment to this email.
>
> Your reports at a minimum should include
>
> - Targets for hackathon events at Month 3, 6, and 9 and Phase 1 Base evaluation
> - Initial data and information on challenges provided by MITRE
> - Software development plan considering specifications of human-in-the-loop interaction provided by TA4.

# Summary

Macrostrat's core goal is to provide the highest-possible quality geologic basemap for CMA workflows. We will integrate TA1 extracted maps and TA2 literature information, keyed by geological unit.

## Success criteria for Macrostrat TA4 system

- Can we provide TA1 and TA2 data to TA3 (and other TA4 performers), en masse?
- Can we provide augment and standardize these datasets to provide relevant lithologic info?

## System goals

Feed TA2 data to TA3

- Make mine report data sub-settable by geologic formation, lithology, etc. through linking to TA1 output (and geologic mapping from other sources)
- Provide these point data objects using standardized APIs that can be queried and assimilated in TA3 modeling

## Adjustments in response to initial challenges

We have adapted our approach somewhat in light of initial integrations with other performers and discussions with other TAs. Key new things we would like to emphasize:

We will plan to integrate with tools produced by other TA4 performers:

- Jataware will produce some end-to-end solutions particularly for georeferencing and page-level evaluation of map data objects.
- MTRI will work with TA4 to ensure that geologic mapping data can be filtered and subset

Based on descriptions of bottlenecks in CMA process workflows described by Lawley,
and the expected structure of TA1 and TA2 outputs, we forecast that a major problem will
be assembing a geologic dataset well-characterized and standardized enough to be useful across scales and study areas to extract fairly specific CMA-relevant information.
Given this expected challenge, we will devote extra effort to internally characterizing and harmonizing geologic map units, in order to provide appropriately queryable TA1 and TA2 datasets.

# Software development plan

## Map integration

As a first step towards HITL interfaces to standardize map geological information (e.g., legend data, line types, etc.) from TA1 outputs, we're going to try to improve the speed and interactivity of Macrostrat's vector data ingestion pipeline. This system moves from heterogeneous inputs, like Geodatabases, Shapefiles, or the old ArcInfo files you referenced, to the standardized layers that drive Macrostrat APIs.

Geologic map ingestion is reliant both on GIS data manipulation (and in the case of TA1 performers, image analysis), and on geological expertise. Geological decisions include splitting up unit ages from stratigraphic names, descriptions, and lithological information in legend text, which must in many cases be done manually. It's obviously useful to allow the geologic expertise to be applied without the need for SQL manipulation, as that will allow geologists to more readily participate.

We will build a web-based interface to allow geologists to interactively manipulate map data, and to provide feedback on the quality of the map data. This will operate over:

- Vector datasets in general (for assimilating already digitally-published mapping and TA1 outputs for representation in Macrostrat)
- paired vector/raster map datasets (to facilitate training by TA1)

### Relevant software repositories

- [Macrostrat CLI](https://github.com/UW-Macrostrat/cli) holds processing interfaces
- [Map integration system](https://github.com/UW-Macrostrat/map-integration) will hold map ingestion/harmonization web app
- [Python libraries](https://github.com/UW-Macrostrat/python-libraries): monorepo for Python libraries used across projects

### Milestones

- Initial demo: Month 3 hackathon

## Providing geologic datasets to TA3

### Geologic map data

- [Tileserver](https://github.com/UW-Macrostrat/tileserver)

Tiled Macrostrat output, API-available in vector-based tile format has gained agreement from MTRI (TA4) and SRI (TA3) that it has the requisite structure and properties to be used as a base for CMA workflows. We will continue to refine this output and provide it to TA3. We will work on

- improving the structure of tileserver output to better support querying by TA3 (ex., adding ).
- Improving API capabilities for querying and filtering by relevant data fields
- Integrating attribute types discussed by Lawley et al. (2022) and others, such as age ranges, paleolatitude, and vetted lithologic classes.

![Tiled Macrostrat output for provision to TA3](img/tiled-macrostrat-output.png)

### Mineral site data

We have successfully validated serving and filtering of point datasets relevant to CMA, including the MRDS dataset. Approaches to curating point data and linking it closely to geologic context (enabling spatial and geological time/unit filtering)

Mine sites synthesized from TA2 will be linked to geologic context and forwarded to TA3 and TA4 HITL interfaces (ex., MTRI and/or EIS QGIS plugins).

Macrostrat maintains links to other point datasets that may be useful to forward to TA3, and will continue to assimilate more

### Raster datasets

Raster datasets can usually be easily accessed directly by TA3. However, compositing raster datasets across scales, etc. presents demanding workflows that can be supported by TA4 potentially. We have validated and will maintain key capabilities to store and serve raster datasets, to support map feedback and CMA workflows.

- [Macrostrat Raster CLI](https://github.com/UW-Macrostrat/raster-cli)

This can also be used to help support TA1 feedback

## Geologic entity characterization

- Macrostrat maintains a database of geologic entities, which can be used to further characterize geologic maps

Two separate approaches:

1. Find new descriptors of existing entities
2. Find new entities not currently tracked in the database

This will help correct several deficiencies of Macrostrat's current representation of geologic units:

- Lack of information about non-sedimentary units
- Lack of specificity about

![Entity canonicalization](img/entity-canonicalization.png)

## HITL interfaces

Our plan is to produce key HITL interfaces, especially to support TA1 and TA2

### Map-feedback interfaces

![Paired vector/raster map feedback interface](img/paired-vector-raster.png)

_Map interface showing both vector and raster datasets for the same geologic map, in an interface with synthesized legend information_

- [Macrostrat web](https://github.com/UW-Macrostrat/web)
- [Macrostrat web components](https://github.com/UW-Macrostrat/web-components)

### Map editing

- [Mapboard topology](https://github.com/Mapboard/topology-manager)

![Mapboard interface](img/mapboard-interface.jpg)

![Mapboard PostGIS](img/mapboard-postgis.png)

### Document-based interfaces

- Coordinate with Jataware for TA2-supporting interfaces
- [COSMOS visualizer](https://github.com/UW-COSMOS/cosmos-visualizer) page-level annotation interface may be adapted, or a Jataware-created tool may be used

<img src="img/cosmos.png" alt="COSMOS visualizer" width="400"/>

## Targets for hackathon events

### Month 3 hackathon

- Import pipeline for geologic maps (TA1 outputs)
  - Feedback mechanism for map legend extractions
- Synthesis of these outputs into TA3-ready products
  - First attempts, showing maps in the right structure but not properly attributed

### Month 6 hackathon

- Demonstrated pipeline to accrue descriptive characteristics of rock units from literature synthesis
  - Pathway to involve TA2 in providing data to this pipeline
  - Pathway to involve TA3+USGS in providing feedback and HITL effort towards synthesizing geologic entities
- Goal: produce "clean" and highly specific lithologic breakdowns of rock formations amenable to querying by TA3

### Month 9 hackathon

### Phase 1 Base evaluation

# Summary of current progress

## System and interaction design

- Macrostrat team has spearheaded the production of schemas for data interchange with TA1-3
- Key additions to the schema: geologic data objects

## Providing literature extractions to TA1 and TA2

- GeoKB as document source - We switched from using the USGS (Sky's?) Zotero instance as the primary metadata source for target documents to the GeoKB SPARQL instance. This aligns us with the storage and knowledge plans of Sky's group. This includes storing the w3id stable URLs.
- Created a set (`criticalmaas`) defined as the union of these documents with the USGS series publications (doi prefix of 10.3133)
- COSMOS, word2vec, and doc2vec pipelines from of the entire set have been started and are done to varying degrees of completion. None have the live endpoints yet for this particular set (though we have them complete for the GeoKB-based articles)
- We will continue to integrate with TA2 to build capabilities around accessing and manipulating the literature corpus of documents from USGS and other sources.

## Progress to initial milestones

We are making progress on all proposed milestones. All but one deliverable proposed for execution by Month 4 have crossed key thresholds in readiness and are near completion, except for a single deliverable in Task 3B. The early establishment of key capabilities allows us to focus on building integrations with other performers (in all TAs) during and after the Month 3 hackathon.

### Task 1: Supply geological data and literature artifacts to CriticalMAAS TAs 1-3

_Augment and extend Macrostrat and xDD systems to deliver data and artifacts to TAs 1-3_

#### 1A: Extend Macrostrat for TAs 1-3

_Augment Macrostrat capabilities and datasets with functionality for AI-assisted critical mineral assessment._

1. **Milestone 2** _(Month 4)_: A containerized instance of Macrostrat: A containerized version of Macrostrat is running but not stable, and is being used as a base for all development activities
2. **Milestone 2** _(Month 4)_: Database and software capabilities to ingest and serve raster datasets: Initial validation complete
3. **Milestone 2** _(Month 4)_: User management and authentication: **In initial stages of development, planned by Month 3 hackathon**
4. **Milestone 2** _(Month 4)_: APIs to deliver geologic map and column data to TAs1-3: APIs based around existing map and tileserver APIs have been partially implemented, and deficiencies in data structure and queryability are being identified and evaluated.

#### 1B: Extract literature artifacts using xDD-COSMOS and deliver to TA1-2

_Provide literature artifacts (maps and tables) to TA1-2_

1. **Milestone 1** _(Month 2)_: A vetted corpus of geological literature pertinent to mineral assessment: The CriticalMAAS corpus is available
2. **Milestone 2** _(Month 4)_: Pipeline for delivering contextualized literature artifacts to TA 1 and 2: COSMOS outputs for maps, table extractions, etc. are available

### Task 2: Ingest geological data from TAs 1-3

_Incorporate data products produced by TAs 1-3 into Macrostrat_

#### 2A: Ingest geologic maps from TA1 and link entities

_Incorporate TA1 map data products into harmonized Macrostrat map system_

1. **Milestone 1** _(Month 1)_: Schemas for map data to be accepted by Macrostrat system: Done as part of TA4 deliverable
2. **Milestone 2** _(Month 4)_: Documented ingestion APIs for maps from TA1: Beginning to produce ingestion CLI and API for TA1 use

#### 2B: Ingest geological data from TA2 and link entities

_Augment and extend Macrostrat map and column unit data to include mineral assessment-specific criteria_

1. **Milestone 1** _(Month 1)_: Schemas for point-based geological data to be accepted by Macrostrat system: Done as part of TA4 deliverable
2. **Milestone 2** _(Month 4)_: Documented APIs for point-based data ingested from TA2 (and TA1 as applicable): Started in Weaver repository

### Task 3: Build HITL interfaces for model and extraction improvement

_Build and deploy interfaces to annotate existing and TA- generated data with expert feedback_

#### Subtask 3A: Annotate and edit geologic maps

_Enable dynamic editing and annotation of geologic maps_

1. **Milestone 2** _(Month 4)_: Add widgets for collecting map candidate feedback to Macrostrat’s web map interface: In early development

#### Subtask 3B: Annotate geological data extractions and linked geological entities

_Enable annotation of geological data extracted from descriptive documents_

1. **Milestone 2** _(Month 4)_: Add widgets for collecting linked entity feedback in Macrostrat web interfaces: **Not yet addressed**

## Later milestones

We have made some progress to later Phase 1 milestones, as well:

- Subtask 1B **Milestone 4** _(Month 7)_: Pipeline for locating and extracting entities and augmenting Macrostrat database: In early exploratory phases with CS graduate and undergraduate students supervised by co-PI Venkataraman.
- Subtask 3A **Milestone 4** _(Month 7)_: Adapt Mapboard GIS topological editing for map geospatial/topology correction: Key demonstration/validation has been accomplished
