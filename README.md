# UW-Macrostrat CriticalMAAS

Project overviews, roadmaps and milestone reports for Macrostrat's contribution
to the DARPA/USGS CriticalMAAS program.

## Key links

- [`dev2.macrostrat.org`](https://dev2.macrostrat.org): Development instance of
  Macrostrat housing new CriticalMAAS capabilities
- [`v2.macrostrat.org`](https://v2.macrostrat.org): Staging instance of 'core'
  Macrostrat services using the streamlined CriticalMAAS codebase and
  infrastructure
- [`macrostrat.org`](https://macrostrat.org): Macrostrat's v1 production website

## Codebase

This is an index of the software repositories that have been contributed to in
the Macrostrat / UW–Madison CriticalMAAS effort, as of Milestone 4 (March 2024).

### Macrostrat core system

Macrostrat's core system consists of a database of geological maps,
stratigraphic columns, and the data dictionaries and lexicons that describe
them. The core codebase contains the capabilities required to run a functional
instance of Macrostrat, including its ingestion pipelines, APIs, and web
interfaces. This system is the primary deliverable of the Macrostrat
CriticalMAAS effort; by the end of the project, it will be well-documented and
deployable by USGS staff and other users with a `macrostrat up` command.

- [`UW-Macrostrat/macrostrat`](https://github.com/UW-Macrostrat/macrostrat):
  Macrostrat's core system, including database definitions, control scripts, and
  ingestion pipelines.

#### Key dependencies

- [`UW-Macrostrat/tileserver`](https://github.com/UW-Macrostrat/tileserver):
  Server for vector and raster tiles to GIS software and TA3
- [`UW-Macrostrat/api-v3`](https://github.com/UW-Macrostrat/api-v3):
  Macrostrat's v3 API, which will be the primary API for new capabilities,
  including CriticalMAAS
- [`UW-Macrostrat/python-libraries`](https://github.com/UW-Macrostrat/python-libraries):
  Python libraries used throughout Macrostrat server and control applications,
  including tools for database access and data processing.

#### Web interface

Macrostrat's web interface is the primary way of exposing Macrostrat's
capabilities to users. Through CriticalMAAS, we are adding new capabilities
including access to individual maps, a staged ingestion interface, and new human
interfaces for managing links between geological units and the scientific
literature.

- [`UW-Macrostrat/web`](https://github.com/UW-Macrostrat/web): Macrostrat's main
  web interface codebase
- [`UW-Macrostrat/web-components`](https://github.com/UW-Macrostrat/web-components):
  Shared React/Typescript user interface components for map-based user
  interfaces

### Program coordination

Schemas, data interchange libraries, and shared infrastructure for the
CriticalMAAS program.

- [`DARPA-CriticalMAAS/ta1-geopackage`](https://github.com/DARPA-CRITICALMAAS/ta1-geopackage):
  a GeoPackage-based data format for validating and storing TA1 output
- [`DARPA-CriticalMAAS/schemas`](https://github.com/DARPA-CRITICALMAAS/schemas):
  A repository for schemas and data formats for TA1-3 integrations (_started by
  UW–Macrostrat and subsequently contributed to by all TA teams_)
- [`UW-xDD/document-store`](https://github.com/UW-xDD/document-store): A
  supplemental store for public/user provided PDFs that provides full-text
  access, integrates with xDD APIs. **Note: This repository is being integrated
  into the CDR codebase.**

### Geologic metadata curation

We are working towards building better rock-record descriptions from the
geological literature, both by discovering concepts linked to known geological
units (relationship extraction) and finding new units (named entity resolution).
Several machine-learning approaches are being deployed towards this
knowledge-graph curation problem:

- [`UW-Macrostrat/unsupervised-kg`](https://github.com/UW-Macrostrat/unsupervised-kg):
  Unsupervised knowledge graph construction to discover new entities and
  relationships from geological literature (_Devesh Sarda_; UW–Madison computer
  science).
- [`UW-Macrostrat/llm-kg-generator`](https://github.com/UW-Macrostrat/llm-kg-generator):
  LLM-assisted graph generation to extracts geological facts, operating over the
  scientific literature to characterize batches of geologic names (_Bill Xia_;
  UW–Madison computer science)

Tools initiated outside of CriticalMAAS are also being adapted to support these
metadata curation workflows:

- [`UW-xDD/text2graph_llm`](https://github.com/UW-xDD/text2graph_llm): A tool to
  transform textual data into structured graph representations, using LLMs to
  identify and extract relationship triplets from text. It focuses on extracting
  relationships between locations and geological entities from the text.
- [`UW-Madison-DSI/ask-xDD`](https://github.com/UW-Madison-DSI/ask-xDD): A chat
  interface and API endpoint for accessing academic information via
  Retrieval-Augmented Generation (RAG). The
  [prototype](http://cosmos0001.chtc.wisc.edu:8501/) currently covers topics
  such as geoscience, climate change, and COVID-19.

An infrastructure
([`UW-Macrostrat/macrostrat-xdd`](https://github.com/UW-Macrostrat/macrostrat-xdd);
_placeholder for future development)_ will orchestrate the bulk deployment of
these models against Macrostrat's
[existing lexicon of geologic names](https://dev2.macrostrat.org/lex/strat-names);
results will be standardized, linked to data dictionaries, and stored in
Macrostrat's database. A feedback interface (currently in development; see
[early prototype](https://dev2.macrostrat.org/lex/strat-names/6)) will allow
users to correct extracted descriptions, as well as establish _de novo_
relationships. After initial deployment, this pipeline will be extended with
"named entity recognition" capabilities to identify and describe rock units not
known to Macrostrat.

<!--
We are also working on extract metadata from maps:

- [`UW-Macrostrat/map-metadata-curation`](https://github.com/UW-Macrostrat/map-metadata-curation):
  Documentation of efforts to align current archive of maps with **Macrostrat
  v2** data standards. Focus on point data, raster image alignment, and
  ingestion metadata recovery (_Kate Akin_; Geoscience)
-->

### External integrations

Macrostrat is integrated with systems that provide additional functionality
relevant to CriticalMAAS. Major adjustments to these systems are out-of-scope
for the CriticalMAAS project, but integrations with Macrostrat can provide
useful capabilities to the CriticalMAAS program.

- [**Mapboard topology-manager**](https://github.com/Mapboard/topology-manager):
  Topological map manager for PostGIS databases (for editing **TA1** maps and
  topologically synthesizing them for Macrostrat output layers)
- [**Corelle**](https://github.com/UW-Macrostrat/corelle): Paleogeographic
  rotation system compatible with GPlates
- [**xDD**](https://xdd.wisc.edu/): A system for extracting geologic metadata
  from the scientific literature
- [**Mapboard GIS**](https://mapboard-gis.app): An iPad-based GIS for
  geologists, with a focus on rapid, intuitive drawing (for **TA1** map editing
  if required)
- [**Weaver**](https://github.com/digitalcrust/weaver): Ingestion, curation,
  performant filtering, and visualization of massive geological point datasets
  (for **TA2** data integration)

## Documentation

Documentation is associated with individual project repositories. Additionally,
some broad documentation is being coordinated across the project towards
building a cohesive, deployable system.

The [`UW-Macrostrat/docs`](https://github.com/UW-Macrostrat/docs) (_placeholder
for future development_) repository will contain broad system documentation and
improve discoverability and usability.

### Map interface examples

The [`v2.macrostrat.org/dev`](https://v2.macrostrat.org/dev) and
[`v2.macrostrat.org/map/dev`](https://v2.macrostrat.org/map/dev) websites
contain examples of Macrostrat's map services for raster, vector, and
point-based data.

### API documentation

- [Tileserver (v2)](https://tileserver.staging.svc.macrostrat.org/docs)
- [Macrostrat ingestion API documentation (v2)](https://v2.macrostrat.org/api/ingest/docs)
- [Macrostrat API documentation](https://v2.macrostrat.org/api/)
- [Macrostrat API tutorials](https://docs.google.com/document/d/13uLxrS0sI9qmLIERtVvegwXa6_063V5Mz82DzJ9LArw/edit)

### Document extraction

- [COSMOS visualizer example](https://xdd.wisc.edu/set_visualizer/sets/dolomites?query=Belle%20Fourche):
  A demonstration of the COSMOS visualizer used to showcase data from a document
  set relative to carbonate rocks.
- [Design for document management system](https://github.com/UW-xDD/document-store/blob/main/docs/design_doc.md)
- [xDD API documentation](https://xdd.wisc.edu/api/)
- [xDD example notebook](./notebooks/xDD and COSMOS examples.ipynb): A Jupyter
  notebook demonstrating the xDD API

### TODO

- [x] Build [a documentation website](https://dev2.macrostrat.org/docs)
      (_preliminary website is up_)
- [x] Document new Macrostrat APIs using the OpenAPI specification in order to
      conform to common standards.
- [x] Establish documentation websites for
      [shared web components](https://github.com/UW-Macrostrat/web-components)
      and [Python libraries](https://github.com/UW-Macrostrat/python-libraries)
- [ ] Create and document a process for setting up an empty Macrostrat database,
      populated with data dictionaries

## Project documents

> Compiled documents are stored in a S3 and linked to below. To download all
> documents, run `make` in the root directory of this repository.

- [Project whitepaper](https://storage.macrostrat.org/web-assets/criticalmaas/media/2023-08-CriticalMAAS-UW-whitepaper.pdf)
  _(August 2023)_: A trimmed-down version of the proposal, detailing goals and
  potential deliverables.
- [Kickoff slides](https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2023-08-CriticalMAAS-kickoff-slides.pdf)
  _(August 2023)_: A brief overview of the Macrostrat platform and goals,
  presented by PI Daven Quinn at the kickoff meeting.
- [Phase 1 research plan](https://storage.macrostrat.org/web-assets/criticalmaas/media/2023-10-CriticalMAAS-Phase-1-research-plan.pdf)
  _(October 2023)_: A detailed plan for the first phase of the project,
  including a timeline and deliverables.
- [Milestone 2 report](https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2023-12-CriticalMAAS-Milestone-2-report.pdf)
  _(December 2023)_: A report detailing the progress of the project
- [6 Month hackathon weekly activity report](http://storage.macrostrat.org/web-assets/criticalmaas/media/2024-02-CriticalMAAS-6Month-Hackathon-Weekly-Activity-Report.pdf)
  _(February 2024)_: A report on progress during the 6 month hackathon (Denver,
  CO)
- [Milestone 3 report](https://storage.macrostrat.org/web-assets/criticalmaas/media/2024-02-CriticalMAAS-Milestone-3-report.pdf)
  _(February 2024)_: A report detailing the progress of the project

## Project Milestones

### Phase 1

| #   | Milestone                                                                                                                                                                 | Exit Criteria         | Target Date | Product |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- | ----------- | ------- |
| 0   | [Specifications for TA 1-3](https://github.com/DARPA-CRITICALMAAS/schemas)                                                                                                | Specifiation Plans    | 09/2023     |         |
| 1   | [Detailed research plan for Phase 1](https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2023-10-CriticalMAAS-Phase-1-research-plan.pdf)                   | Milestone Report      | 10/2023     |         |
| 2   | [Initial code/documentation release](https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2023-12-CriticalMAAS-Milestone-2-report.pdf)                      | Milestone Report/Code | 12/2023     |         |
| 3   | [Report detailing progress of research and technology and gaps](https://storage.macrostrat.org/web-assets/criticalmaas/media/2024-02-CriticalMAAS-Milestone-3-report.pdf) | Milestone Report      | 02/2024     |         |
| 4   | Code/documentation/data release                                                                                                                                           | Milestone Report/Code | 03/2024     |         |
| 5   | Report detailing progress, capabilities, gaps, and final integration plans                                                                                                | Milestone Report      | 04/2024     |         |
| 6   | Report with challenge evaluation results, working code and documentation and end-to-end integration                                                                       | Milestone Report/Code | 07/2024     |         |

> ### Appendix: Out-of scope codebases
>
> #### Archived repositories
>
> These repositories are not currently being actively developed, having been
> integrated into Macrostrat's core system at
> [`UW-Macrostrat/macrostrat`](https://github.com/UW-Macrostrat/macrostrat)
>
> - [`UW-Macrostrat/map-integration`](https://github.com/UW-Macrostrat/map-integration):
>   Geologic map ingestion and harmonization
> - [`UW-Macrostrat/cli`](https://github.com/UW-Macrostrat/cli): Macrostrat
>   system management tools
> - [`UW-Macrostrat/raster-cli`](https://github.com/UW-Macrostrat/raster-cli):
>   Prototype tool for ingesting raster datasets
>
> #### Private repositories
>
> - [`UW-Macrostrat/tiger-macrostrat-config`](https://github.com/UW-Macrostrat/tiger-macrostrat-config):
>   Macrostrat configuration for CHTC infrastructure. Private due to its tight
>   integration with UW–Madison CHTC systems.
> - [`UW-Macrostrat/macrostrat-api`](https://github.com/UW-Macrostrat/macrostrat-api):
>   Macrostrat's v1-2 APIs is deprecated and contains sensitive information
>   impacting Macrostrat's production services. A simplified and
>   security-audited v3 API will be released as part of CriticalMAAS.
>
> #### Document extraction handling
>
> These document handling repositories are maintained as part of the
> [xDD](https://xdd.wisc.edu/) system, and will be called on as necessary for
> the CriticalMAAS project.
>
> - [`UW-COSMOS/cosmos-visualizer`](https://github.com/UW-COSMOS/cosmos-visualizer):
>   Page annotation and feedback
> - [`UW-COSMOS/COSMOS`](https://github.com/UW-COSMOS/COSMOS): PDF entity
>   extraction pipeline
