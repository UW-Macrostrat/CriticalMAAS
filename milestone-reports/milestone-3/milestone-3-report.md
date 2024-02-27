# Introduction {-}

This **Milestone 3** report covers UW-Madison – Macrostrat contributions to the
CriticalMAAS project for the period from December 21, 2023 through February 23,
2024 (Months 4-6). We describe progress during that period towards the research
and technical goals defined in our [Phase 1 Research Plan][phase1_plan] and
[Milestone 2][milestone2] code/documentation release, gaps in addressing the
program goals, and the results of baseline integrations and capability
demonstrations from the CriticalMAAS Month 6 Hackathon (_Denver, CO_).

Our approach to CriticalMAAS os based around Macrostrat, a principled,
analysis-oriented geologic framework to harmonize maps and other geological
knowledge products (e.g., stratigraphic columns) into a descriptive model of
crustal rocks. This system is already accessible via stable, performant, and
open web services that support wide use, and geologically oriented user
interfaces that allow exploration. We seek to enhance this system by adding new
data ingestion capabilities and tools for feedback and expert contribution.
Additionally, we seek to use literature-supported machine learning pipelines to
augment this system with structured data (e.g., rock unit lithologies) that can
inform querying and analysis. We have made significant progress in each of these
domains.

# Research and technical progress: Macrostrat geologic framework

Our core task for CriticalMAAS is to develop pipeline to integrate TA1 mapping
data into a geologic data product that can be used by TA3. Our work has largely
proceeded as laid out in the [Phase 1 Research Plan][phase1_plan], and we are
midway through the development of a system that will support rapid map ingestion
and standardization. At the **Month 6 Hackathon**, we demonstrated an end-to-end
pipeline for ingesting geologic mapping from TA1 into Macrostrat, and providing
a standardized representation of those datasets to TA3 for critical minerals
modeling. This represents the initial demonstration of a system integration
required for the success of CriticalMAAS.

By the end of Phase 1, we are committed to delivering a complete, runnable
Macrostrat map curation system to USGS; we are on track to do so. The prototype
system is housed in the [`UW-Macrostrat/macrostrat`][gh:macrostrat] repository,
which integrates formerly separate components into a unified, open-source
representation of Macrostrat's database schema, map ingestion pipelines, and
geological data integration tooling.

The successful end-to-end demonstration of this system relied on several areas
of development that we have pursued over the last several months; we detail the
progress in each of these areas below. In the coming months, we will streamline
and extend this pipeline to support quick, accurate capture of geologic mapping
datasets [@sec:gaps] and ingestion of more maps into the system
[@sec:vector-maps].

## TA1 GeoPackage library

Macrostrat entered the CriticalMAAS program with a well-established
understanding of the most effective structure for geologic map data, and we have
been working to convey this understanding on TA1 teams. Following our success in
leading the design of [TA1 data schemas][ta1-schema], we have led the effort to
establish specific formats for TA1 data products, in order to establish
authoritative, consistent standards for candidate map interchange and archival.

The [`DARPA-CriticalMAAS/ta1-geopackage`][ta1-geopackage] Python library
provides a common interface for TA1 to deliver geologic maps to Macrostrat. The
library wraps the GeoPackage format, which is a recognized "best-practice"
standard for geospatial data delivery. We additionally bake the [TA1
schemas][ta1-schema] into the file format, to ensure that data types and
references are consistent between teams. This schema is supplemented by a set of
utilities based on `fiona` and `geopandas` Python libraries to write data into
the format. The resulting file contains all data that the TA1 teams generate for
a given map, and it can be opened natively in QGIS, ArcGIS, and other GIS
environments. We have designed Macrostrat ingestion/export scripts to work with
the file format as well.

We conceived of this direction just before our **Milestone 2** and began
socializing the idea with TA1 teams in December 2023. The library was developed
and refined in early January. Integration with TA1 teams started in mid-January,
and by the **Month 6 Hackathon**, all TA1 teams had shifted to using this file
format to deliver candidate maps to Macrostrat via our S3 buckets; ~90 maps have
been provided and ingested into Macrostrat's data pipelines
[@sec:map-ingestion]. At the moment, TA1 teams have implemented the schema to
varying degrees, and we have been working to support their full compliance with
the format. The library is now under collaborative refinement with TA1 workers,
who have contributed bug reports, test cases, and pull requests; it will likely
underpin internal integration between TA1 teams and storage of TA1 data in the
CDR.

## Map ingestion pipeline

Macrostrat's map ingestion pipeline allows geologic maps from a variety of
sources to be integrated into a harmonized representation. In CriticalMAAS, we
have committed to extend this pipeline to rapidly integrate high-resolution,
high-quality geologic maps from TA1 and other sources [@sec:vector-maps],
thereby applying standardized representations of age, lithology, and named
geological units and bringing them into a unified geological representation to
support critical minerals modeling. We have made significant progress on
streamlining this map ingestion pipeline to support the rapid ingestion of
geologic maps, and have staged almost 200 maps into the system. Notably, at the
**Month 6 Hackathon**, we successfully ingested several TA1 maps fully into
Macrostrat's harmonized web representation, making them available alongside
existing maps in Macrostrat's API and web interfaces.

We have made significant progress on the ingestion pipeline for TA1 data.

- scaled our system to stage ~100 new NGMDB vector geologic maps
- fully ingested several TA1 maps as a proof of concept
- Using a service-oriented approach to provide harmonized geologic map data to
  TA3
- Validated transformation of existing maps for rapid HITL editing in an
  iPad-based interface

https://github.com/brianaydemir/macrostrat-map-ingestion: This is a
proof-of-concept pipeline (collection of scripts) for importing vector maps into
Macrostrat. It's been tested on:

- 95 maps from the Nevada Bureau of Mines and Geology (NBMG) [84 had shapefile
  data that we could import]
- 9 maps from the National Geologic Map Database (NGMDB) that had GIS data
  linked directly from their main page [6 had shapefile data that we could
  import]
- The maps submitted by TA1 performers UIUC and UMN/Inferlink, and Uncharted at
  the 6-month hackathon (~90 total)

In comparison, this 210 maps is about 70% of the total number of maps ingested
into Macrostrat from 2016-2023 (294). Although most of these maps are not fully
through the ingestion pipeline, their initial staging represents a substantial
increase in the rate of map assimilation into Macrostrat. Our task for the next
phase of the project is to speed up this pipeline

At the hackathon, we learned that the basic structure of the pipeline was sound.
For example, that it made sense to have a "customizable" step for "scraping"
maps from a given location

- (We wrote custom "scraper" for S3 buckets for the hackathon in maybe half an
  hour).
- I "learned" that the pipeline, as currently, implemented, has far too many
  human touch points to be effective when well-packaged maps are coming in
  quickly.

- However, some steps, particularly the HITL step , is unwieldy

Next steps:

- Retool the pipeline/scripts so that it still preserves the ability to
  re-process a map that might only partially made it through the process while
  not requiring so many human touch points. Ideally, a human (or periodic tasks)
  says "go", and everything else happens automatically, as much as is possible
  given the input data.

- Make Jataware map key a first class citizen in identifying a map throughout
  the process
- Create UIs to display a maps stage of ingestion
- Create UIs for lines and points
- Add feedback tools for lines, points and polygons

![Map ingestion result](./images/uiuc-vector-raster-1068.jpg) _**Hackathon
result:** TA1 map extraction atop Jataware-indexed raster map in Macrostrat's
web user interface_

## Macrostrat geologic exploration interface

Once maps are ingested into Macrostrat, they become part of a user-facing,
web-available cyberinfrastructure designed for exploration and analysis. This
system is widely used by geologists and the public for rapid exploration of
geologic information in a rich user interface. As part of CriticalMAAS, we have
been working to extend this interface with more capabilities for exploration of
the geologic data contained in our database (see
[the Macrostrat development website](https://dev2.macrostrat.org)). These
capabilities will soon be extended to support feedback on geological entities
within the system [@sec:feedback].

Key capabilities such as single-map views and paleogeographic reconstructions
that were discussed in the **Milestone 2** report continue to be developed. One
small but important addition is hooks to Jataware's raster storage system,
allowing georeferenced Cloud-Optimized GeoTIFF maps to be displayed alongside
their vector equivalents in the Macrostrat web interface
([See example map](https://dev2.macrostrat.org/maps/1068)). We have also made
substantial progress on new visualizations for our geologic lexicon
[@sec:geologic-entities] and, most notably, **stratigraphic columns**.

Macrostrat's stratigraphic column dataset is a rich index of geologic data in
the subsurface of North America and is unique in its scale and consistency. This
dataset has been queryable via Macrostrat's API, but lack of straightforward
visualization has limited its usefulness for exploration and modeling.
Macrostrat's column visualization, now publicly available at
[`dev2.macrostrat.org/columns`](https://dev2.macrostrat.org/columns), allows
more intuitive and geologically sophisticated interaction with Macrostrat's
column dataset. The interface can be explored alongside the geologic map
interface, and ties between stratigraphic and map datasets will be made more
explicit in future iterations of the tool. In the future, this new capability
can support the integration of geologic maps as well. Map datasets generally
have a time-stratigraphic element, which can usually be extracted from map
legend unit descriptions; thus, stratigraphic visualizations can provide a
useful capability to evaluate the quality and consistency of TA1 map datasets.

![Stratigraphic column visualization](./images/macrostrat-map-interface.jpeg)
_Stratigraphic column visualization in Macrostrat's web interface_

![All maps](./images/all-maps.jpeg) _TA1 output in the context of other maps in
Macrostrat's web interface — including an existing representation of the same
map._

## Provision of TA1 geologic maps to TA3

Our map APIs have supported standardized querying since the start of the program
and present a stable target for integration with TA3. MTRI has built a pipeline
for querying Macrostrat that allows our tile-based API output to be
straightforwardly brought into a QGIS data table at any scale.

# Research and technical progress: xDD literature integration

## The CriticalMAAS Document Store

- New document store system allows using xDD alongside full-text services over
  open-licensed documents managed by CriticalMAAS
- Will support better feedback interfaces including Jataware’s document
  annotator
- Initial pipelines for entity extraction of geologic unit names from scientific
  literature using graph- and RAG-based approaches

The xDD services that drive our geologic unit characterization pipelines are
also highly relevant to TA2.

We realized prior to **Milestone 2** that we needed a clearer delineation
between functionality to build ML tools and HITL workflows atop documents, and
search/discovery of documents. We have clarified this distinction and are
building a new system to support the latter, the
[`UW-xDD/document-store`][document-store] repository. This system will provide

xDD for finding documents, Document Store for services atop program documents
seems like a pretty good division for me

In terms of ingest, the only info from xDD we depend on currently is document
title and DOI. It should be pretty quick to spin up a new endpoint that
allows/requires a user to submit those along with PDF content. The bigger issue
is discoverability, since we don't store any info about document text in the
document store right now. If we are fine with just title-based search for
starters it should be possible to accomplish that relatively quickly though

Document discovery services will be provided by xDD.

if people are adding their own documents, presumably they will be able to find
them again based on whatever criteria. The main thing is just allowing other
documents to get in there, so in case there are things referenced from other
knowledge bases etc. they can be tracked.

## Document entity extraction

COSMOS pipelines attracted interest from TA2

![COSMOS UI](./images/cosmos-ui.jpeg) _COSMOS UI for surfacing geologic entities
from the scientific literature_

### xDD / COSMOS feedback

- The ability to find closely grouped sets of terms (eg. specific processing
  techniques used on specific minerals)
- A set of sample Jupyter notebooks for API usage
- A more user-friendly interface for querying xDD
- A tool to download the results of API queries in a more scientist-friendly
  format (csv, excel), rather than JSON
- COSMOS extractions run on geologically relevant articles outside of the
  critical-maas dataset
- Ability to back-reference COSMOS extractions to the source document
- Specific COSMOS label for maps, or a separate extraction for maps A tool to
  extract the text from COSMOS table extractions

## Geologic unit characterization

In the CriticalMAAS month 3 workshop and weekly TA3 meetings, the need for
consistent and well-defined geologic attributes for geologic maps has gained
increasing focus. Even advanced, AI-driven mineral systems studies such as
[Lawley et al, 2023][lawley2023] have had to build consistent geologic attribute
sets (particularly around lithologic classification for rock units) by hand, at
significant time expense for geological experts. Our integrations with **TA1**
and **TA2** seek to address this need. In addition, we have also been working to
augment Macrostrat structured data with geologic information from the scientific
literature. This effort, in early development, is described in the
[`UW-Macrostrat/macrostrat-xdd`](https://github.com/UW-Macrostrat/macrostrat-xdd)
repository. Of note for this milestone, two projects by UW–Madison graduate and
undergraduate students demonstrate early approaches to this problem:

- [`UW-Macrostrat/factsheet-generator`](https://github.com/UW-Macrostrat/factsheet-generator):
  An LLM-assisted generator for geological "fact sheets" that operates over the
  scientific literature (_Bill Xia_)
- [`UW-Macrostrat/unsupervised-kg`](https://github.com/UW-Macrostrat/unsupervised-kg):
  Knowledge graph construction to discover new geologic entities in the
  scientific literature (_Devesh Sarda_)

![Candidate lithology extraction](./images/candidate-lithology-extractions.png)
_Candidate lithology extractions from scientific literature, represented in a
prototype feedback interface_

### Status

- Utilized a entity hinting based relationships based extraction to get
  predefined relationships for entities in the Macrostrat database
- Also finetuned the REBEL model to perform triplet extraction which doesn’t
  need predefined relationships
- Created script to link the relationships back to the Macrostrat database and
  write the triplets to predefined schema
- You can find information about the models and how they work here:
  https://github.com/sarda-devesh/unsupervised-kg/tree/main. In terms of future
  work: Create an initial dataset of paragraph level relationships we want to be
  able to be extract as well define benchmark metrics out of that Look into
  performance of existing models on paragraph level relationships

# Research and technical progress: Program integration

![Program flow chart](./images/criticalmaas-flow-chart.svg) _CriticalMAAS
program flow chart showing software (black boxes), data management workflows
(red), and HITL workflows (purple) being built by TA4 teams_

One of the main goals of TA4 is to facilitate data interchange across the
CriticalMAAS program. Indeed, to build HITL tooling across such a disparate set
of performers requires careful attention, although such "data-pipelining"
activities are mostly implicit in the BAA.

The UW-Macrostrat team has led the development of several infrastructure
components for the CriticalMAAS program. At Milestone 2, the broad design of
these components had gained broad agreement among other teams. In
December–February, we built out these components and introduced them to the
broader program.

The goal of these program elements is to establish key integrations that can be
carried into the design of the "CriticalMAAS Data Repository."

- [`DARPA-CriticalMAAS/ta1-geopackage`][ta1-geopackage]: a GeoPackage-based data
  format for validating and storing TA1 output
- [`UW-xDD/document-store`][document-store]: A supplemental store for
  public/user provided PDFs that provides full-text access, integrates with xDD
  APIs.
- [`DARPA-CriticalMAAS/schemas`](https://github.com/DARPA-CRITICALMAAS/schemas):
  A repository for schemas and data formats for TA1-3 integrations (_started by
  UW–Macrostrat and subsequently contributed to by all TA teams_)

Taken together, these integrations represent significant time spent on program
alignment, with good results. We expect that the detailed plans we have
established will speed our future development. These efforts were based on an
expectation that the development of the _CriticalMAAS data repository_ should be
a distributed effort among the TA4 teams.

# Gaps

Scaling up: our infrastructure is substantially more complex than before to meet
map throughput. We are in a learn/adjust phase Orienting computing researchers
and staff towards solving geological problems (microcosm of program challenge)
CDR plans Our database/data formats are closely tied to our system design — a
major integration with an external store would be substantial unplanned work We
have spent substantial time developing program-oriented APIs we seek to use
Access to USGS mapping (modern/vector as well as TA1) Cannot produce a
meaningfully “best-in-class” analytical capability without incorporating the
best modern mapping USGS internal problem, to my understanding

## Map ingestion throughput

## Finding vector maps

## TA3 query workflow

Macrostrat's standardized API allows querying both a harmonized, multiscale
geologic map and single maps.

We have not yet established a clear workflow for querying the Macrostrat API for
TA3. This is a significant gap, as it is the primary mechanism for delivering
geologic data to TA3. We have established a basic API for TA3 to query
Macrostrat, but have not yet established a clear workflow for how TA3 will use
this API to access the data they need. This is a significant gap in our current
system, and we will need to work closely with MTRI to establish this workflow.

- Adapt MTRI's Python library into a Macrostrat API client with a clear workflow
  for staged querying of data to assemble complex result sets.

## Feedback interfaces

One major gap in our current system is the lack of tools to provide feedback
over the geologic data we are ingesting from TA1 and accumulating from entity
characterization. Two major feedback mechanisms are needed

The [Document store](#document-store) provides a backbone for feedback
mechanisms for TA2 datasets, but similarly to the map ingestion pipeline,
progress on specific interfaces and workflows awaits deep engagement with the
TA2 teams. Now that TA4 has established a workflow for accessing TA2 datasets
since the Month 6 hackathon, we will be able to build feedback interfaces in the
coming months. For TA2, we will seek to coordinate closely with Jataware to
ensure that we are not building redundant systems.

# Issues and concerns

## Clarity and pacing of CDR work plan

From the DARPA program management, we have heard both that TA4 is behind on CDR
implementation, and some indications that the CDR needs to be a highly specific
system, yet there has seemed to be reticence to discuss specific requirements
and plans.

Some aspects of the CDR seem geared towards satisiying reporting requirements
and evaluation driven by DARPA, but others are more focused on product technical
needs, in particular for data searchability/accessibility. These capabilities
are at least notionally aligned with the goals of TA4 as expressed in the BAA
and developed over the course of the project through coordination between TA4
teams. However, specific capabilities (e.g., pub-sub APIs for data tracking, or
the need for data search and visualization via web browser) require very
different development paths. It is also unclear the extent to which CDR goals
must be fulfilled by a "single system" maintained at the program level by CDR
leaders (Jataware) or whether existing services collected in a more distributed
fashion can meet the need. If the latter, it is unclear how many program-level
requirements for data tracking, etc. will need to be built to adapt the services
to DARPA requirements.

Jataware being put at the center of the CDR effort is a sensible choice, given
their flexible capacity and responsiveness to DARPA. However, the design of the
CDR should be responsive to the needs of the program as a whole, which we are
also attuned to. And, given our organizational anchoring in geoscience, we have

Overall, we are continuing to coordinate with other TA4 teams to build
integrations with TA1-3, but we do not have significant input or insight into
the CDR work plan. Therefore, we are exposed to risk that our development
activities, including those geared towards productive integration with TA1-3
(e.g., the [Document Store][document-store] and [TA1 Geopackage
format][ta1-geopackage]), will be misaligned with CDR requirements. To mitigate
this, we will continue to work with Jataware and MTRI to design healthy and
productive interactions with TA1-3 and clarify the specific design requirements
for our systems.

## Inefficient reporting

Too many "out-of-band" reporting requirements

- Posters
- Milestone reports
- Wrap-up reports for hackathon
- "Weekly activity reports" for DARPA

These all take significant time, over and above the already substantial time
weight of coordinating between TAs.

# Appendix 1: Index of software repositories {-}

Code and documentation for this milestone are indexed in the [**UW–Macrostrat
CriticalMAAS README**][readme] at the root of the the
[`UW-Macrostrat/CriticalMAAS`](https://github.com/UW-Macrostrat/CriticalMAAS)
GitHub repository. The overall structure of the codebase has not changed
substantially since [Milestone 2][milestone2], but we have made significant
progress on implementing research goals by developing this infrastructure. We
report on this progress here.

- [`DARPA-CRITICALMAAS/schemas`](https://github.com/DARPA-CRITICALMAAS/schemas):
  Schemas for TA1-3 integrations (@sec:schemas)
- [`DigitalCrust/weaver`](https://github.com/digitalcrust/weaver): Curation and
  ingestion of geological site datasets (@sec:mineral-sites)
- [`Mapboard/topology-manager`](https://github.com/Mapboard/topology-manager):
  Topological map editing (@sec:map-editing)
- [`UW-COSMOS/cosmos-visualizer`](https://github.com/UW-COSMOS/cosmos-visualizer):
  Page annotation and feedback (@sec:document-interfaces)
- [`UW-COSMOS/COSMOS`](https://github.com/UW-COSMOS/COSMOS): PDF entity
  extraction pipeline (@sec:geologic-literature)
- [`UW-Macrostrat/CriticalMAAS`](https://github.com/UW-Macrostrat/criticalmaas):
  Index repository for the CriticalMAAS project
- [`UW-Macrostrat/macrostrat-xdd`](https://github.com/UW-Macrostrat/macrostrat-xdd):
  xDD integration for geologic entity characterization
  (@sec:entity-characterization)
- [`UW-Macrostrat/raster-cli`](https://github.com/UW-Macrostrat/raster-cli):
  Prototype tool for ingesting raster datasets (@sec:raster-data)
- [`UW-Macrostrat/tiger-macrostrat-config`](https://github.com/UW-Macrostrat/tiger-macrostrat-config):
  Configuration for CHTC infrastructure (_private_; @sec:macrostrat-system)
- [`UW-Macrostrat/tileserver`](https://github.com/UW-Macrostrat/tileserver):
  Server for vector and raster tiles to GIS software (@sec:geologic-map-data)
- [`UW-Macrostrat/web-components`](https://github.com/UW-Macrostrat/web-components):
  Shared user interface components for Macrostrat user interfaces
  (@sec:map-interfaces)
- [`UW-Macrostrat/web`](https://github.com/UW-Macrostrat/web): Macrostrat's main
  web interface (@sec:map-interfaces)

# Appendix 2: Progress towards technical plan {-}

In addition to the specific advances highlighted above, we are making progress
towards the broad technical tasks outlined in our [Phase 1 Research
Plan][phase1_plan]. We have made significant progress towards our **Milestone
4** (Month 7) deliverables across all task areas:

- We are broadly on schedule with program tasks
- Poised to hit next major milestone (active TA1 maps pipeline)
- Behind on feedback interfaces, but are building underlying tooling to move
  quickly with TA1/2 products on the table
- Since 1-year mark was originally defined as a “Proof of concept” our planned
  tasking back-weighted some stabilization tasks the 6-month option, which may
  make impact our ability to deliver a fully-functioning system in the 1-year
  timeframe.
- Financial status is fine
  - We are spending as programmed on staff
  - Scaling up our infrastructure impacts our fiscal position after the end of
    the program, as Macrostrat has not incurred or supported this level of
    ongoing expense before

#### **Task 1**: Updated and containerized Macrostrat system

- **T1a**: A containerized instance of Macrostrat: _complete, running at
  [v2.macrostrat.org](https://v2.macrostrat.org)_
  - Database and software capabilities to ingest and serve raster datasets
  - User management and authentication: _complete_
  - APIs to deliver geologic map and column data to TAs1-3: _complete and
    documented_
  - Raster data APIs: _We will utilize Jataware's raster pipeline for TA1_
- **T1b**: Pipeline to synthesize information from the geologic literature: _in
  progress, see
  [`UW-Macrostrat/macrostrat-xdd`](https://github.com/UW-Macrostrat/macrostrat-xdd)_

#### Task 2: Ingest geological data from TAs 1-3

- **T2a**: Documented ingestion APIs for maps from TA1: _file format structure
  is established, and ingestion has been validated on existing NGMDB maps_
- **T2b**: Documented APIs for point-based data ingested from TA2 (and TA1 as
  applicable)

### Task 3: Build HITL interfaces for model and extraction improvement

- **T3a**: Add widgets for collecting map candidate feedback to Macrostrat’s web
  map interface: _complete; in internal testing_
- **T3b**: Add widgets for collecting linked entity feedback in Macrostrat web
  interfaces: _in development_

[readme]: https://github.com/UW-Macrostrat/CriticalMAAS/blob/main/README.md
[phase1_plan]:
  https://storage.macrostrat.org/web-assets/media/criticalmaas/2023-10-CriticalMAAS-Phase-1-research-plan.pdf
[milestone2]:
  https://storage.macrostrat.org/web-assets/media/criticalmaas/2023-12-CriticalMAAS-Milestone-2-report.pdf
[lawley2023]: https://doi.org/10.1007/s11053-023-10216-1
[milestone_3_report]:
  https://storage.macrostrat.org/web-assets/media/criticalmaas/milestone-reports/milestone-3/milestone-3-report.pdf
[gh:macrostrat]: https://github.com/UW-Macrostrat/macrostrat
[ta1-geopackage]: https://github.com/DARPA-CRITICALMAAS/ta1-geopackage
[document-store]: https://github.com/UW-xDD/document-store
[ta1-schema]: https://github.com/DARPA-CRITICALMAAS/schemas/tree/main/ta1
