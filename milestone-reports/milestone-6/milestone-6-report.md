# Report period

This **Milestone 6** report covers progress by the UW–Madison/Macrostrat team
during the period from 2024-05-07 to 2024-11-03, including progress at the
9-month hackathon and the final part of Macrostrat's Phase 1 delivery (months
8-12). It also includes progress during a 3-month no-cost extension to the
project, which pushed final delivery from August to November 2024.

# Research and technical progress

During this reporting period, the Macrostrat–UW Madison team has focused on
supporting mineral prospectivity modeling for TA3 teams, enhancing HITL
pipelines for maps and literature-derived information, contributing design
insights to the CDR based on our capabilities and geological expertise, and
completing the final code and infrastructure elements of our Phase 1 delivery.
Our research has led to advancements in several areas targeted by CriticalMAAS,
which we discuss here.

## Infrastructure development and CDR integration

During the project, Macrostrat's core systems were generalized, modularized, and
containerized to increase their flexibility to incorporate new and high-volume
data sources, especially CriticalMAAS maps. Additionally, elements of the system
were planned to be integrated into the CDR, either through API-based access or
as overlays to the database. The services that make up the core of Macrostrat
were moved a Kubernetes-based infrastructure and released as open-source
software to facilitate use by other teams. This new version of Macrostrat is now
running at [https://v2.macrostrat.org](https://v2.macrostrat.org) and can be
stood up as a local instance using a "seed" database dump and `docker-compose`
using the [`UW-Macrostrat/macrostrat`][gh:macrostrat] repository.

Macrostrat has substantial software capabilities that overlapped with
CriticalMAAS needs, including management of geologic map data at scale,
integration of multiple data sources into a unified modeling framework, and the
ability to serve maps to users with high performance to thousands of users
daily. Additionally, the xDD side of our team has substantial expertise with
processing documents. Our team made several key contributions to CDR design,
including:

- Leading the development of project's data integration schemas
  [`DARPA-CRITICALMAAS/schemas`][gh:schemas] (months 1-4)
- The [`UW-xDD/document-store`][gh:document-store] system for storing and
  querying documents (months 3-6)
- Tile server schema and API design for serving and visualizing geologic maps
  (months 9-12)

These elements were mostly superseded and not directly integrated into the CDR,
but in many cases the basic design principles and philosophy were adopted by the
program. (A key example of this is the core data fields used to describe
geologic units in the CDR, which were based on Macrostrat's existing data
model.) More direct and substantial integration of our capabilities would have
been beneficial to the program had it been a priority beyond our team.

## Geologic map integration

One of the major elements of Macrostrat's delivery is an integration pipeline to
align geological maps into Macrostrat's database systems and data expectations.
Though the primary target is CriticalMAAS maps, the pipeline is designed
generally to allow geologic maps to be brought in from a variety of sources,
including from GIS-ready file formats. (Most maps of high interest for
prospectivity modeling are already digitized but do not include structured
geological data.)

At the 9-month hackathon, we demonstrated a refined version of this pipeline
targeting CriticalMAAS maps that was able to make them "analysis-ready" quickly
after their publication to the CDR, using its API. The impact of our pipeline
was limited by the fact that, at the time, the CDR had only just gained the
ability to store projected geologic maps. Still, we were able to ingest maps
from the CDR and serve them to TA3 using Macrostrat's tile-based API, which is
performant and produces data ready for both analysis and visualization.

## Data products in support of mineral prospectivity modeling

During Phase 1, Macrostrat has produced a number of data products and tools that
are useful to mineral prospectivity modeling The first of these is our
geological mapping API, which has been successfully used through the course of
the program to generate harmonized, regionally-consistent geologic maps for
visualization and analysis. During the 9-month hackathon, we were able to
provide geologic maps to TA3 teams using Macrostrat's APIs, via Python-based
tools to query and stitch the results produced by MTRI
([`DARPA-CRITICALMAAS/macrostratpy`][gh:macrostrat_client]). We also inaugurated
capabilities for server-side filtering that make basic filtered queries (by rock
unit age or lithology) possible. These capabilities proved impactful at the
9-month hackathon, where the pipeline from TA1 maps to TA3 analysis was fully
connected, using Macrostrat's API endpoints as a bridge. While these tools met
the analytical needs of the TA3 teams, they did not fit into the program-level
CDR plan, so were subsequently de-emphasized. However, some of the tileserver
elements created by Macrostrat were incorporated into the CDR after the 9-month
event.

In addition to harmonized geologic map datasets, we were able to produce unique
stratigraphic data products that cannot be constructed in most other systems. We
demonstrated a capability to produce thickness isopach maps of specific rock
types and stratigraphic intervals, based on Macrostrat's unique stratigraphic
dataset and API ([`DARPA-CriticalMAAS/macrostrat-isopachs`][gh:isopachs]).
During the 9-month hackathon, this capability was deployed to produce a
thickness map of "Cambrian and Ordovician dolomites", a rock type and time
interval of particular interest for Mississippi Valley-type lead-zinc deposits.
This capability is entirely API-based and applicable to arbitrary rock types and
depositional settings. This basic capability can be improved by integrating
cross sections and structural surfaces (e.g., "depth to formation top" maps)
into Macrostrat's geologic framework. This future work will allow isopachs
generated in a similar manner to the above to be more accurate and applicable to
structurally complex domains.

Macrostrat's design is well-suited to producing the harmonized mapping and
stratigraphic data products that are needed for TA3, and it does so in a
scalable, performant, and conceptually sophisticated way. Both data products
benefit from substantial work to standardize lithologic and age descriptors for
rock units described in maps and columns. The capabilities developed during
CriticalMAAS Phase 1 to support mineral prospectivity modeling will be
integrated with Macrostrat's other offerings and will remain available for
similar modeling tasks in the future.

## Knowledge graph development

Through our work at xDD, the UW–Madison team originated CDR records for ~50,000
documents mining reports and scientific papers relevant to specific Critical
Minerals problems. More interestingly, these were paired with extractions (e.g.,
the coordinates of figures, tables, and maps within PDFs) correlated with
in-document mentions of specific minerals and deposit types. We made some
progress to pushing these data to the CDR at the 9-month hackathon, but the APIs
were not quite ready to accept this data at that point. Still xDD remains
well-placed to supply document information to the CDR based on the patterns
established during the program.

The main thrust of our work with xDD, however, was research into ways to more
effectively integrate literature data about geologic units and mineral
occurrences into Macrostrat's data models. Such a pipeline would allow rapid
extraction of information from documents while preserving the ability to query
and search over a structured representation of the knowledge. The initial goal
during CriticalMAAS Phase 1 was to build an approach to extract basic
information (e.g., lithology, grain sizes, mineral contents) about named
geologic units from papers and mining reports that mention them. The main reason
that we sought a no-cost extension was to complete this work, which depended on
the academic schedule of several students that led the modeling elements of this
work.

As our final delivery of Phase 1, we've completed an end-to-end pipeline that
handles extraction, evaluation, and retraining of knowledge-graph construction
models that support this type of data extraction. We've tested both BERT-based
knowledge-graph construction approaches and LLM prompting approaches, which can
both output properly formatted data, but often with a low degree of accuracy in
their classification of tokens. To improve this, we've built a feedback user
interface that will allow geoscientists to classify relationships to build a
tree-like set of relationships (e.g. `Bonneterre Formation` > `dolomite` >
`laminated`) from paragraphs that can be used as training data for the models.
The current pipeline supports continuous retraining for the knowledge graph
construction models, including linking structured model extractions to
Macrostrat's data dictionaries. All elements of this pipeline have been tested,
including retraining steps. However, user feedback has not yet been constructed
in enough volume to produce model improvements.

### Software elements

Macrostrat's knowledge-graph construction pipeline is now a standalone software
system with several moving parts, which are summarized below.

#### Modeling frameworks

1. A LLM-based modeling framework
   ([`UW-Macrostrat/llm-kg-generator`][gh:llm-kg-generator])
2. A BERT-based modeling framework
   ([`UW-Macrostrat/unsupervised-kg`][gh:unsupervised-kg])

#### Data extraction and evaluation

1. A database of extractions from xDD documents (based on Critical
   Minerals-related corpora), knowledge graph links and nodes, and links to
   structured data dictionaries (housed in Macrostrat's PostgreSQL database and
   defined in the [`UW-Macrostrat/macrostrat`][gh:macrostrat] repository)
2. An API server for accepting new knowledge graph entities and relationships
   from models and user feedback, validating them and linking to structured data
   dictionaries, and storing in the database
   [`UW-Macrostrat/macrostrat-xdd`][gh:macrostrat-xdd]

#### User feedback interface

1. A web-based interface for geoscientists to classify relationships extracted
   from documents, which can be used as training data for the models
   ([`UW-Macrostrat/web`][gh:macrostrat-web] and
   [`UW-Macrostrat/web-components`][gh:web_components])
2. An ORCID-based authentication system that allows feedback by authorized
   collborators from multiple institutions atop Macrostrat's web infrastructure.

### Next steps

The pipeline is now ready for deploy for feedback and model retraining, which is
a significant step. While we have not yet demonstrated success at producing
structured data from model outputs at scale, we are confident that this pipeline
represents an approach that can be applied towards multiple scientific goals.
Ongoing work will focus on training the models by collecting more feedback data,
and on exploring ways to include LLM-based models in the training steps, such as
improving prompt design and context selection. We anticipate that this research
will ultimately lead to a principled approach to assembling structured datasets
from descriptive text, with substantial supporting tools.

## Human-in-the-loop interfaces

In addition to building data pipelines to support mineral prospectivity modeling
and literature data extraction, we have built exploratory human-in-the-loop
(HITL) interfaces that allow interaction with different elements of geologic
data. We have enhanced existing approaches to map and stratigraphic column
visualization to make it easier to evaluate geological information and
constraints (for instance, web-based, inspectable visualizations of TA1 map
datasets). We have also created web-based table views of lithology data that
make it easier to inspect and filter data holdings.

We've also built prototype tools for iteratively managing map topology (e.g.,
[`Mapboard/topology-manager`][gh:topology-manager]) and rapidly editing geologic
maps in a web interface ([`Mapboard/mapboard-platform`][mapboard_platform]).
Although these have some overlaps in functionality with the Polymer product from
Jataware, they are performant and flexible and will likely be useful for
constructing "publication-ready" maps from TA1 data. Development of these HITL
tools will continue alongside other Macrostrat activities, and we will continue
to refine them as modular web components
([`UW-Macrostrat/web-components`][gh:web_components]) that can be used in other
geologically rich applications going forward.

# Summary

We've delivered mostly what we wanted to, although some things are not yet fully
complete. However, this is the nature of research programs and we anticipate
that things will continue to be improved in the future. We agree with program
management that there were many missed opportunities for integrating our
substantial capabilities and know-how with the program but, but suspect that
many of these integration challenges were due to aspects of the program and
activities of other teams that were out of our control.

This has also been a learning opportunity for the Macrostrat team.

These contributions remain truly "research" in that they are exploratory
capabilities without straightforward CDR integrations, but that is both in
keeping with what we can effectively deliver on our own and with the role of the
program. Moreover, in line with our expertise, they are are sophisticated and
geologically advanced prototypes that lay the groundwork for future advances in
critical minerals prospecting and geologic data integration more generally.

[gh:criticalmaas]: https://github.com/UW-Macrostrat/CriticalMAAS
[gh:macrostrat]: https://github.com/UW-Macrostrat/macrostrat
[ta1-geopackage]: https://github.com/DARPA-CRITICALMAAS/ta1-geopackage
[document-store]: https://github.com/UW-xDD/document-store
[cosmos]: https://github.com/UW-COSMOS/COSMOS
[mapboard_platform]: https://github.com/Mapboard/mapboard-platform
[gh:topology-manager]: https://github.com/Mapboard/topology-manager
[gh:python_libraries]: https://github.com/UW-Macrostrat/python-libraries
[gh:web_components]: https://github.com/UW-Macrostrat/web-components
[gh:isopachs]: https://github.com/DARPA-CRITICALMAAS/macrostrat-isopachs
[mapboard-gis]: https://mapboard-gis.app
[phase1_plan]:
  https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2023-10-CriticalMAAS-Phase-1-research-plan.pdf
[milestone_3_report]:
  https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2024-02-CriticalMAAS-Milestone-3-report.pdf
[milestone_4_report]:
  https://storage.macrostrat.org/web-assets/criticalmaas/media/2024-04-CriticalMAAS-Milestone-4-report.pdf
[readme]: https://github.com/UW-Macrostrat/CriticalMAAS/blob/main/README.md
[gh:macrostrat_api]: https://github.com/UW-Macrostrat/macrostrat-api
[gh:macrostrat_api_v3]: https://github.com/UW-Macrostrat/api-v3
[gh:tileserver]: https://github.com/UW-Macrostrat/tileserver
[lawley2023]: https://doi.org/10.1007/s11053-023-10216-1
[poplar]: https://github.com/synyi/poplar
[gh:macrostrat-xdd]: https://github.com/UW-Macrostrat/macrostrat-xdd
[gh:unsupervised-kg]: https://github.com/UW-Macrostrat/unsupervised-kg
[gh:llm-kg-generator]:
  https://github.com/UW-Macrostrat/llm-kg-generator/tree/pipeline
[gh:macrostrat_client]: https://github.com/DARPA-CRITICALMAAS/macrostratpy
