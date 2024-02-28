# Introduction {-}

This **Milestone 3** report covers UW-Madison – Macrostrat contributions to the
CriticalMAAS project for the period from December 21, 2023 through February 23,
2024 (Months 4-6). We describe progress during that period towards the research
and technical goals defined in our [Phase 1 Research Plan][phase1_plan] and
[Milestone 2][milestone2] code/documentation release, gaps in addressing the
program goals, and the results of baseline integrations and capability
demonstrations from the CriticalMAAS Month 6 Hackathon (_Denver, CO_).

Our approach to CriticalMAAS is based around Macrostrat, a principled,
analysis-oriented geologic framework to harmonize maps and other geological
knowledge products (e.g., stratigraphic columns) into a descriptive model of
crustal rocks. This system is already accessible via stable, performant, and
open web services that support wide use, with geologically-oriented user
interfaces that allow exploration. We are enhancing this system and tuning it
for use in CriticalMAAS by adding new data ingestion capabilities and tools for
feedback and expert contribution. Additionally, we seek to incorporate
literature-connected machine learning pipelines to augment this system with
structured data (e.g., rock unit lithologies) that can further inform querying
and analysis tasks specific to CriticalMAAS modeling requirements. We have made
significant progress in each of these domains.

# Research and technical progress: Macrostrat geologic framework

Our core task for CriticalMAAS is to develop pipeline to integrate TA1 mapping
data into a geologic data product that can be used by TA3. Our work has largely
proceeded as laid out in the [Phase 1 Research Plan][phase1_plan], and we are
midway through the development of a system that will support rapid map ingestion
and standardization. At the **Month 6 Hackathon**, we demonstrated an end-to-end
pipeline for ingesting geologic mapping from TA1 into Macrostrat, and providing
a standardized representation of those datasets to TA3 for critical minerals
modeling. This represents the initial demonstration of the system integrations
and data throughput required for the success of CriticalMAAS.

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
been working to convey this understanding to TA1 teams. Following our success in
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
sources to be integrated into a harmonized representation, which is critical for
leveraging mapd data in regional and continental-scale mineral assessments. In
CriticalMAAS, we have committed to extend this pipeline to rapidly integrate
high-resolution, high-quality geologic maps from TA1 and other sources
[@sec:vector-maps], thereby applying standardized representations of age,
lithology, and named geological units and bringing them into a unified
geological representation to support critical minerals modeling. We have made
significant progress on streamlining this map ingestion pipeline to support the
rapid ingestion of geologic maps, and have staged almost 200 maps into the
system. Notably, at the **Month 6 Hackathon**, we successfully ingested several
TA1 maps fully into Macrostrat's harmonized web representation, making them
available alongside existing maps in Macrostrat's API and web interfaces.

Since **Milestone 2**, we have greatly updated the infrastructure supporting
Macrostrat's map ingestion pipeline. The pre-CriticalMAAS system was designed
around expert-led ingestion in a manual, ad-hoc fashion, relying on direct
database inserts and custom SQL scripts for each ingested map. This system was
effective for ingesting a few dozen maps per year (Macrostrat's recent ingestion
rate) with a high degree of control, but it was not scalable to the thousands of
maps that we expect to ingest over the course of CriticalMAAS; it also only
minimally tracked data provenance. We are midway through retooling this system
into a more robust, scalable, and automated pipeline that includes storage
buckets for candidate maps (TA1 GeoPackages and other vector datasets),
automated ingestion scripts, and a repeatable HITL workflow for legend
correction and standardization. The core of this pipeline is being built in the
[`UW-Macrostrat/macrostrat`][gh:macrostrat] repository; it is supplemented by
[source-specific scripts](https://github.com/brianaydemir/macrostrat-map-ingestion)
for acquiring potential vector maps. Going forward, we seek to integrate our map
acquisition process with Jataware's web-scraping approach [@sec:gaps].

We have validated the Macrostrat map ingestion pipeline both for staging new
datasets into the system and for HITL curation and assimilation into our
standardized data services. Broadly, map staging is now rapid and automated, and
there is a bottleneck in HITL legend curation that we are working to address
[@sec:map-ingestion-throughput]. The new web scraping/ingestion pipeline has
been tested on several collections of maps spanning a range of input data
formats and levels of completeness:

- 95 maps from the Nevada Bureau of Mines and Geology (NBMG), including 84 with
  Shapefiles that we could import
- 9 maps from the National Geologic Map Database (NGMDB) that had GIS data
  linked directly from their main page (6 had shapefile data that we could
  import)
- 93 maps (including partial/incomplete datasets) submitted by TA1 performers
  UIUC, UMN/Inferlink, and Uncharted during the 6-month hackathon, covering maps
  relevant to the "MANIAC" magmatic nickel challenge

The successful bulk staging of maps is a significant step for Macrostrat's
infrastructure. The 210 maps staged since the beginning of February represent
about 70% of the total number of maps ingested into Macrostrat from 2016-2023
(294). Although most of these new maps are not fully through the legend curation
pipeline, their ingestion represents a substantial increase in the rate of
Macrostrat's ability to assimilate new mapping data.

The hackathon provided a valuable opportunity to "stress-test" this ingestion
system, and we verified that the basic structure of the pipeline is sound under
load. The system can handle both maps provided in a controlled way with a
standardized schema (e.g., TA1 datasets uploaded to a S3 bucket) and other map
formats that are not yet standardized (e.g., vector geologic maps in NGMDB with
varying attribute schemas). However, we also identified several areas that need
substantial improvement. The pipeline, as currently implemented, has far too
many human touch points to be effective when well-packaged maps are coming in
quickly. Some steps need more attention to data pipeline design others require
more interaction with TA1 to ensure schema compliance. In particular, the HITL
legend-curation step, which is managed in a table-based web interface, is
unwieldy and slow due to both the complexity of the task and poor user interface
design. We are working to address these issues in the coming months.

Despite the slow pace of HITL curation, we were able to demonstrate the
ingestion of maps from TA1 into Macrostrat, successfully staging several maps
produced during the hackathon into the system. Once data-format concerns were
addressed with TA1 teams, the ingestion process was straightforward and quick,
though it required a significant amount of manual intervention. Although there
are clear gaps to be filled, successful demonstration of our map ingestion
system represents a major proof of concept for our overall approach to
integrating mapping data.

![Map ingestion result](./images/uiuc-vector-raster-1068.jpg) _**Hackathon
result:** TA1 map extraction atop Jataware-indexed raster map in Macrostrat's
web user interface_

## Macrostrat geologic exploration interface

Once ingested into Macrostrat, maps become part of a user-facing, web-available
cyberinfrastructure designed for data distribution and analysis. This system is
already widely used by geologists and the public for rapid exploration of
geologic information in rich web and mobile user interfaces. As part of
CriticalMAAS, we have been working to extend our interfaces with additional
capabilities for geologic data exploration relevant to mineral systems (see
[the Macrostrat development website](https://dev2.macrostrat.org)).

These capabilities will soon be extended to support feedback on geological
entities within the system [@sec:feedback].

Key capabilities that were discussed in the **Milestone 2** report (e.g.,
single-map views and paleogeographic reconstructions) continue to be developed.
One small but important addition is hooks to Jataware's raster storage system,
allowing georeferenced Cloud-Optimized GeoTIFF maps to be displayed alongside
their vector equivalents in the Macrostrat web interface
([See example map](https://dev2.macrostrat.org/maps/1068)). We have also made
substantial progress on new visualizations for our geologic lexicon
[@sec:geologic-entities] and, most notably, **stratigraphic columns**.

Macrostrat's stratigraphic column dataset is a rich index of the subsurface
rocks of North America; it is unique in its scale and consistency and provides
another "view" of geologic information about the crust alongside maps. This
dataset is queryable via Macrostrat's API, but a lack of straightforward
visualization has limited its usefulness for exploration and modeling.
Macrostrat's column visualization, now publicly available at
[`dev2.macrostrat.org/columns`](https://dev2.macrostrat.org/columns), allows
more intuitive and geologically sophisticated interaction with Macrostrat's
column dataset. Columns can be explored alongside the geologic map interface,
and navigation between datasets will be made more explicit in future iterations
of the tool. In the future, this new capability can support the integration of
geologic maps as well. Since geologic maps also have a time-stratigraphic
element alongside their spatial footprint, stratigraphic visualizations can
provide a useful capability to evaluate the quality and consistency of TA1 maps
and legend extractions.

![Stratigraphic column visualization](./images/macrostrat-map-interface.jpeg)
_Stratigraphic column visualization in Macrostrat's web interface_

![All maps](./images/all-maps.jpeg) _TA1 output in the context of other maps in
Macrostrat's web interface — including an already-ingested vector dataset for
the same map._

## Providing TA1 geologic maps to TA3

Macrostrat's geologic map APIs support standardized querying of our geologic
maps and present a stable target for integration with TA3. Importantly, these
APIs are designed to work similarly for both single maps and the Macrostrat
"harmonized" map, which is a composite from maps at multiple scales. Thus, the
TA1 maps that we have ingested into Macrostrat's system can be accessed in a
straightforward way. MTRI has built a library for querying Macrostrat that
allows our tile-based API output to be straightforwardly brought into a QGIS
environment and "re-merged" into a coherent product, which reduces some of the
complexities of working with streaming tiles. This capability was tested early
in the program, but we validated it during the hackathon by pulling a collection
of rocks matching "mafic" lithologies into QGIS using MTRI's tools. This mostly
went well, validating the basic capability of the system to support TA3
querying. Although improvements must be made in efficiency and specificity of
filtering, the basic capability in place is the final piece of an end-to-end
system for TA1-3 integration, a significant milestone for Macrostrat's role in
CriticalMAAS.

# Research and technical progress: xDD literature integration

## The CriticalMAAS Document Store

Published documents of various types, ranging from USGS Professional Papers to
mining company reports, contain information pertinent to critical minerals
assessments and geological rock unit characterization. CriticalMAAS workflows,
therefore, require a solution for finding, retrieving, and processing relevant
documents for any given mineral system. We realized prior to **Milestone 2**
that a clearer delineation was needed between efficient and effective
search/discovery of documents, which xDD provides, and the deep access to
document content that allows **TA2** to test ML tools and HITL workflows. This
distinction is particularly salient in CriticalMAAS, which relies largely on
documents that are freely and openly licensed unlike most of xDD's corpus.

The needs of CriticalMAAS presented an opportunity to build a new system that
can complement xDD's capabilities for openly licensed documents. As such,
starting in December 2023, we started building the **CriticalMAAS Document
Store** ([`UW-xDD/document-store`][document-store]) to provides
full-page/document services operating over open-licensed documents managed by
CriticalMAAS. It operates alongside existing xDD infrastructure for indexing and
retrieval, and will be geared to supporting annotation and feedback interfaces,
including Jataware’s _Silk_ document annotator, which already can read the
Document Store APIs.

The Document Store is designed to be a standalone CDR component that can be used
independently. Integration with xDD confers several advantages to the Document
Store. Since xDD has already been working with the USGS to acquire, store, and
index relevant documents, the Document Store is "seeded" with a large number of
highly relevant documents, and xDD's search APIs can be used to navigate this
set. However, the only information from xDD that we depend on in the document
store is document title and DOI; in principle, other knowledge curation systems
(e.g., the TA2 knowledge graph) can be integrated with the Document Store along
similar lines.

Currently, the Document Store relies heavily on xDD for metadata search and
document discovery. Title-based search and retrieval is currently possible, but
more complicated search tasks fall back to xDD. If a need is demonstrated for a
truly independent and fully searchable collection of user-contributed program
documents not indexed by xDD, certain xDD services (e.g, ElasticSearch) can be
brought over into the Document Store context.

## Document entity extraction

In addition to providing a baseline for program storage of documents, xDD
provides services over documents that can be valuable for CriticalMAAS. In
particular, the [COSMOS][cosmos] pipeline, which identifies and contextualizes
document entities (e.g., figures, tables, equations, abstracts), has been
successfully used for tasks such as recalling all tables from documents that
mention a specific element, or for finding geologic maps relating to surveys for
specific minerals (_see figure_). This capability was used during the hackathon
to rapidly forward maps related to Nickel to TA1 for ingestion. We are working
to run this pipeline over all CriticalMAAS-relevant documents to provide an
searchable index of document extractions. When combined with the Document Store,
these extractions can "pre-seed" TA2 data curation UIs and pipelines with
relevant snippets of documents, allowing efficient workflows to be built. At the
hackathon, we planned such an integration with Jataware (user interfaces) and
SRI (machine-learning pipelines); we will stand up APIs to provide extractions
in the Document Store framework in the coming months.

In addition to being useful within TA2 pipelines, we conducted a demonstration
at the hackathon geared to exploring xDD and COSMOS as user-facing tools for
document search and discovery. We received valuable feedback from USGS
scientists on these tools including the need for more search capabilities for
closely grouped terms, more API documentation and usage examples, abd improved
labeling of maps and other broad types of figures. We will work to assimilate
these suggestions over time to make xDD a more useful service for discovering
literature related to critical minerals.

![COSMOS UI](./images/cosmos-ui.jpeg) _COSMOS UI for surfacing geologic entities
from the scientific literature_

## Geologic unit characterization

One factor that limits the queryability of Macrostrat geologic maps is the fact
that the lithologic classification of rock units is basic and non-standardized.
This gap is a common stumbling block for quantitative mineral systems modeling,
since mineral occurrences are often tied to certain infrequent features that do
not show up in "bulk" descriptions of map units. Geologists typically solve such
problems by spending lots of time hand-labeling datasets; this was done for the
State Geologic Map Compilation (SGMC) project; [Lawley et al, 2023][lawley2023]
reports that assembling the necessary lithologic classification took months of
overhead even using only regional-scale maps. To extend such an effort to local
maps at the scale desired by CriticalMAAS would be infeasible.

To address this data limitation, we are building a pipeline that can acquire
lithologic information about specific rock units from the geologic literature
using mentions in xDD's corpus. Two approaches are being developed in parallel:
an LLM-based approach
([`UW-Macrostrat/factsheet-generator`](https://github.com/UW-Macrostrat/factsheet-generator);
_Bill Xia_) and a knowledge-graph curation approach
([`UW-Macrostrat/unsupervised-kg`](https://github.com/UW-Macrostrat/unsupervised-kg);
_Devesh Sarda_). Since **Milestone 2**, we have built infrastructure supporting
"end-to-end" extraction of lithologic descriptors for rock units and
presentation as candidate relationships in
[Macrostrat's "lexicon explorer" user interface](https://dev2.macrostrat.org/lex).
Forthcoming feedback tools [@sec:feedback] will allow this dataset to be
augmented by expert geologists; if successful, this line of work will allow
descriptions of the geologic units to be automatically assembled from geologic
reports and papers. Having successfully demonstrated this pipeline, we will
continue to improve the quality of extractions and their integration with
Macrostrat's data services and user interfaces.

![Candidate lithology extraction](./images/candidate-lithology-extractions.png)
_Candidate lithology extractions from scientific literature, represented in a
prototype feedback interface_

# Research and technical progress: Program integration

![Program flow chart](./images/criticalmaas-flow-chart.svg) _CriticalMAAS
program flow chart showing software (black boxes), data management workflows
(red), and HITL workflows (purple) being built by TA4 teams_

One of the main goals of TA4 is to facilitate data interchange across the
CriticalMAAS program. Indeed, building HITL tooling that links such a disparate
set of performers requires careful attention to integration design, although
such "data-pipelining" activities are mostly implicit in the BAA. The
UW-Macrostrat team has led the development several infrastructure components
that are oriented towards these program goals. At **Milestone 2**, we had
established the broad need for these components, and received buy-in from other
teams. Since then, we have built initial functional versions of each of these
components:

- [`DARPA-CriticalMAAS/ta1-geopackage`][ta1-geopackage]: a GeoPackage-based data
  format for validating and storing TA1 output [@sec:ta1-geopackage]
- [`UW-xDD/document-store`][document-store]: A supplemental store for
  public/user provided PDFs that provides full-text access, integrates with xDD
  APIs [@sec:document-store]
- In addition, the Macrostrat system itself has "CDR-like" capabilities (e.g.,
  persistent storage, high availability, and web-based data search and access);
  parts of our goals for the system are explicitly focused around being the
  center point of TA1–TA3 integration [@sec:vector-maps]

Broadly, we have been successful in building these components and beginning to
scaffold data-integration workflows around them. Taken together, these
integrations represent significant time spent on program alignment and backend
services, and we believe that is a success unto itself. We hope to carry these
nascent systems into the implementation of the "CriticalMAAS Data Repository,"
but we are not yet clear on the specific requirements for this system. One key
goal for the next phase of work is to solidify integration plans and scope final
functionality; these plans will be developed in coordination with Jataware and
MTRI. However, the outcome of this planning could have a substantial impact on
our work plan and timeline, especially if significant reorientation is required
around new system designs imposed by the CDR or DARPA program leadership.

# Gaps

Scaling up: our infrastructure is substantially more complex than before to meet
map throughput. We are in a learn/adjust phase that is orienting computing
researchers and staff towards solving geological problems (microcosm of program
challenge).

CDR plans: Our database/data formats are closely tied to our system design — a
major integration with an external store would be substantial unplanned work. We
have spent substantial time developing program-oriented APIs we seek to use
Access to USGS mapping (modern/vector as well as TA1) Cannot produce a
meaningfully “best-in-class” analytical capability without incorporating the
best modern mapping USGS internal problem, to my understanding

## Map ingestion throughput

For example, we learned that it made sense to have a "customizable" step for
"scraping" maps from a given location. To this end we:

Based on the lessons-learned at the hackathon, we have identified several next
steps. In the coming months we plan to:

We have identified several areas for improvement in the pipeline, and we are
working to address these issues in the coming months.

Our task for the next phase of the project is to speed up map integration
pipeline to allow rapid curation of maps staged into the system .

As we push TA1 to better fulfill the metadata requirements in the schema it with
entity canonicalization pipelines being developed over the CriticalMAAS document
store.

Our goal by the **Month 9**

- Retool the pipeline/ingest scripts so that it still preserves the ability to
  re-process a map that might only partially made it through the process while
  not requiring so many human touch points. Ideally, a human (or periodic tasks)
  says "go", and everything else happens automatically, as much as is possible
  given the input data.
- Make the Jataware map key a first class citizen in identifying a map
  throughout the process.
- Create UIs to display a maps stage of ingestion.
- Create UIs for lines and points.
- Add feedback tools for lines, points and polygons.

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

Some aspects of the CDR seem geared towards satisfying reporting requirements
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
also attuned to. Given our organizational anchoring in geoscience, we have

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

# Appendix: Index of software repositories {-}

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
[cosmos]: https://github.com/UW-COSMOS/COSMOS
