# UW-Macrostrat CriticalMAAS

Project overviews, roadmaps and milestone reports for Macrostrat's contribution
to the DARPA/USGS CriticalMAAS program.

## Key links

- [`v2.macrostrat.org`](https://v2.macrostrat.org): CriticalMAAS version of
  Macrostrat
- [macrostrat.org](https://macrostrat.org): Macrostrat's production website

## Project documents

- [Project whitepaper](https://s3.macrostrat.chtc.io/web-assets/criticalmaas/media/2023-08-CriticalMAAS-UW-whitepaper.pdf)
  _(August 2023)_: A trimmed-down version of the proposal, detailing goals and
  potential deliverables.
- [Kickoff slides](https://s3.macrostrat.chtc.io/web-assets/media/criticalmaas/media/2023-08-CriticalMAAS-kickoff-slides.pdf)
  _(August 2023)_: A brief overview of the Macrostrat platform and goals,
  presented by PI Daven Quinn at the kickoff meeting.
- [Phase 1 research plan](https://s3.macrostrat.chtc.io/web-assets/criticalmaas/media/2023-10-CriticalMAAS-Phase-1-research-plan.pdf)
  _(October 2023)_: A detailed plan for the first phase of the project,
  including a timeline and deliverables.
- [Milestone 2 report](https://s3.macrostrat.chtc.io/web-assets/media/criticalmaas/media/2023-12-CriticalMAAS-Milestone-2-report.pdf)
  _(December 2023)_: A report detailing the progress of the project

> Compiled documents are stored in a S3 and linked to below. To download all
> documents, run `make` in the root directory of this repository.

## Codebase

This is an index of the software repositories that are being contributed to as
part of the Macrostrat / UW–Madison CriticalMAAS effort.

### Macrostrat core system

The repositories in Macrostrat's core system will eventually contain the minimum
set of capabilities required to run a functioning instance of Macrostrat. They
will contain the primary deliverables of the CriticalMAAS project and will be
designed to be well-documented and runnable by USGS staff.

- [`UW-Macrostrat/macrostrat`](https://github.com/UW-Macrostrat/macrostrat):
  Macrostrat's core system, including its database definitions, control scripts,
  and ingestion pipelines. This repository is the primary focus of the
  CriticalMAAS project.
- [`UW-Macrostrat/tileserver`](https://github.com/UW-Macrostrat/tileserver):
  Server for vector and raster tiles to GIS software
- [`UW-Macrostrat/web`](https://github.com/UW-Macrostrat/web): Macrostrat's main
  web interface
- [`UW-Macrostrat/api-v3`](https://github.com/UW-Macrostrat/api-v3):
  Macrostrat's v3 API, which will be the primary API for CriticalMAAS
  capabilities

### Reusable libraries

Macrostrat maintains shared libraries that underpin a variety of activities
including CriticalMAAS.

- [`UW-Macrostrat/web-components`](https://github.com/UW-Macrostrat/web-components):
  Shared React/Typescript user interface components for rich map-based user
  interfaces
- [`UW-Macrostrat/python-libraries`](https://github.com/UW-Macrostrat/python-libraries):
  Python libraries used throughout Macrostrat server and control applications,
  including tools for database access and data processing.

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
  access, integrates with xDD APIs.

### Geologic metadata curation

We are working towards building better rock-record descriptions from the geological literature by:
- Discovering concepts linked to known geological units
- Finding new units based on proximity to known entities

The starting point for this is two exploratory projects by UW-Madison computer science students, who are both taking different approaches to the problem:
- [`UW-Macrostrat/llm-kg-generator`](https://github.com/UW-Macrostrat/llm-kg-generator):
  An LLM-assisted generation that extracts geological facts from knowledge graphs, operates over the scientific literature (_Bill Xia_; Computer Science)
- [`UW-Macrostrat/unsupervised-kg`](https://github.com/UW-Macrostrat/unsupervised-kg):
  Unsupervised knowledge graph construction to discover new entitities from geological literature (_Devesh Sarda_; Computer Science)

Eventually, both of these projects will be combined into a final system at [`UW-Macrostrat/macrostrat-xdd`](https://github.com/UW-Macrostrat/macrostrat-xdd). This will allow us to automatically generate new filterable and searchable entities describing rocks and their mineral contents as well as discover new rock entities. A pipeline to facilitate the execution of these different methods has also just begun development. We plan on scaling up these models in the pipeline, so they can be run on a larger corpus of data. The results will be automatically stored in the Macrostrat database along with feedback on the accuracy of the different approaches. We will also integrate the results of this system into [macrostrat.org](https://macrostrat.org) to make these results easily accessible. Doing so will not only allow for TA3 performers to filter by specific criteria when exploring entities but also allow us to build a feedback interface that will be used to continously improve the quality of extracted descriptions. An early prototype of the system can be found in the [development instance of Macrostrat](https://dev2.macrostrat.org/lex/strat-names/6).   

We are also working on extract metadata from maps:
- [`UW-Macrostrat/map-metadata-curation`](https://github.com/UW-Macrostrat/map-metadata-curation):
  Documentation of efforts to align current archive of maps with **Macrostrat
  v2** data standards. Focus on point data, raster image alignment, and
  ingestion metadata recovery (_Kate Akin_; Geoscience)

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

The [Macrostrat Documentation](https://dev2.macrostrat.org/docs/) includes the 
documentation for Macrostrat users and Administrators. It is the main hub for 
how to use and manage Macrostrat services. 

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

- [ ] Build [a documentation website](https://v2.macrostrat.org/docs)
      (_placeholder for future development_)
- [ ] Document new Macrostrat APIs using the OpenAPI specification in order to
      conform to common standards.
- [ ] Documentation websites for
      [shared web components](https://github.com/UW-Macrostrat/web-components)
      and [Python libraries](https://github.com/UW-Macrostrat/python-libraries)
      will be established

## Project Milestones

### Phase 1

| #   | Milestone                                                                                                                                              | Exit Criteria         | Target Date | Product |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------- | ----------- | ------- |
| 0   | [Specifications for TA 1-3](https://github.com/DARPA-CRITICALMAAS/schemas)                                                                             | Specifiation Plans    | 09/2023     |         |
| 1   | [Detailed research plan for Phase 1](https://s3.macrostrat.chtc.io/web-assets/media/criticalmaas/media/2023-10-CriticalMAAS-Phase-1-research-plan.pdf) | Milestone Report      | 10/2023     |         |
| 2   | [Initial code/documentation release](https://s3.macrostrat.chtc.io/web-assets/media/criticalmaas/media/2023-12-CriticalMAAS-Milestone-2-report.pdf)    | Milestone Report/Code | 12/2023     |         |
| 3   | [Report detailing progress of research and technology and gaps](https://github.com/UW-Macrostrat/CriticalMAAS/blob/main/milestone-reports/milestone-3/milestone-3-report.md)                                                                                          | Milestone Report      | 02/2024     |         |
| 4   | Code/documentation/data release                                                                                                                        | Milestone Report/Code | 03/2024     |         |
| 5   | Report detailing progress, capabilities, gaps, and final integration plans                                                                             | Milestone Report      | 04/2024     |         |
| 6   | Report with challenge evaluation results, working code and documentation and end-to-end integration                                                    | Milestone Report/Code | 07/2024     |         |

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
