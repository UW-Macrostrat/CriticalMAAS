# Report period

This **Milestone 5** report describes the the technical progress of the
UW–Madison – Macrostrat team on the CriticalMAAS project, from March 30 – May 7
(Month 8). It sets final expected capabilities and integration plans for the end
of Phase 1, based on the work completed to date and the codebases described in
the [Milestone 4 report][milestone_4_report] in April 2024.

# Research and technical progress

The UW–Madison – Macrostrat team has made significant progress on the
CriticalMAAS project leading up to the 9-month Hackathon. The team has continued
to develop the [core Macrostrat codebase][gh:macrostrat] and extend it for
project objectives, particularly around map ingestion, geologic entity
characterization from the literature, and new APIs to provide targeted subsets
of geologic map data. Additionally, we have continued to develop the [Mapboard
topology manager][gh:topology-manager] codebase for editing geologic maps. Taken
together, these elements form the core of a system that can integrate and
provide access to geologic maps to feed to TA3. During this period our effort
has gone mostly to

- Streamlining data pipelines for map ingestion, feedback collection, and
  editing, in order to consolidate towards a final architecture for the Phase 1
  system.
- Developing user interfaces for all project components that can be the basis
  for feedback from experts and other TA teams during the 9-month hackathon.

Here, we briefly summarize progress in several domains.

## Macrostrat

We have continued to refine the Macrostrat core codebase to enable map ingestion
and eventual standalone operation by the USGS and other partners. This has
mostly consisted of refining Macrostrat's command-line utilities for database
maintenance and migrations, upgrading Macrostrat's APIs, and consolidating the
map ingestion pipelines that we demonstrated at the 6-Month hackathon for more
efficient operation and better visibility of pipeline status.

### Core system upgrades

We have begun explicitly breaking out database schema elements into separate
subsystems that can be managed independently with commands such as
`macrostrat db update <subsystem>`. This has enabled rapid iteration of schema
designs in a modular fashion. This system has been used to experiment with data
structures needed for map ingestion and literature knowledge assimilation.

### Map ingestion pipeline

![Map ingestion tracking overview](./images/map-ingestion-queue.png)

We have continued developing of Macrostrat's map ingestion pipeline with more
tools to manage maps' lifecycle in the Macrostrat system (e.g., the ability to
tag and add metadata to maps during the ingestion process). Additionally, we
have made substantial progress acquiring already-vectorized maps from USGS,
state geologic surveys, and other sources. We have begun to stage these maps
into Macrostrat through automated pipelines. Several procedures that required
multiple CLI commands to be run in sequence have been simplified and converted
into automated 'daemon' processes. As a result

For many maps, significant "expert" work (requiring undergraduate-level
understanding of geology) is still required to standardize legend entries to
Macrostrat's minimum data requirements. Our new metadata tracking tools enable
"triage" of tricky maps and the legend editing HITL itself is now broadly usable
and efficient to support this process. We will demonstrate this tool to USGS
during the 9-month Hackathon to seek feedback and testing; over the summer we
will engage several student workers to enter legend information for new maps.
This new pipeline is broadly similar to our pre-CriticalMAAS practices, but with
many manual steps totally automated, enabling us to ingest maps much more
efficiently. Once TA1 teams conform to the CriticalMAAS schema for legend
extractions, we will be able to automate more of this process.

### Standardized user interface elements

![Table component for viewing and editing map legend entries](./images/table-ui.png)

Macrostrat has long been committed to browser-based user interfaces, which are
highly accessible and require no installation. One of the challenges we have
faced in designing HITL components in a web context is the need to rapidly
scaffold and prototype data manipulation tools with a consistent (and ideally
mostly "self-documenting") user experience. One way we have addressed this is
through creating standardized web components that can form elements of many
different HITL workflows. We have recently finished standardizing some of our
ingestion tables into React components that can be used for any table-based data
editing task, with similar semantics to a spreadsheet across arbitrary data.
Coupled with the [PostgREST](https://postgrest.org) standardized API toolkit for
PostgreSQL and lazy-loading approaches, we are able to provide such table
interfaces over high-scale data, such as Macrostrat's
[entire catalog of geologic units](https://dev2.macrostrat.org/maps/legend)
(>75,000 rows). We have structured this system so that it can easily integrate
data editing and validation tools. These tools have increased our ability to
rapidly scaffold new HITLs and will eventually underpin robust and consistent
editing capabilities. These components are being developed in the
[web-components][gh:web_components] repository.

### APIs for providing mapping to TA3

We are continuing to develop APIs and workflows for TA3 to access the Macrostrat
database. We have produced a basic filterable tile layer that can be used to
access Macrostrat data in a controlled fashion across large areas. The current
filtering approach is solely based on an `AND` concatenated list of lithology
elements, which our defined in our tree-based
[lithology dictionary](https://dev2.macrostrat.org/lex/lithology). This has just
been produced and we will discuss its integration with TA3 and MTRI. Other
approaches to build a more complex filter may eventually be made available,
depending on need. These filtering approaches will be made accessible via the
[Macrostrat client library][macrostrat_client] produced by MTRI and recently
extracted into its own codebase.

![New visualization of Macrostrat's nested lithology dictionary](./images/lithology-dictionary.png)

## Map editing

We have made several upgrades to the [Mapboard][mapboard_platform] map editing
system allowing it to work more effectively alongside Macrostrat's other
services. The codebase has been expanded to allow for multiple map topologies to
be managed in the same PostgreSQL database (in separate schemas). The
[Mapboard topology manager](gh:topology-manager) that forms the core of the
system is now fully implemented as a Python module following modern Macrostrat
coding standards. It has a full test suite with 39 passing tests. We have also
added new features such as separate, nested mapping layers, and control of valid
data types between layers (e.g., so surficial units can be separated from
bedrock units). In advance of the 9-month Hackathon, we are bringing the
Mapboard system into our Kubernetes platform to enable wider testing, with both
QGIS and the [Mapboard GIS iPad app](mapboard-gis) as client interfaces. A web
interface is also in development, but this may not be ready for demonstration at
the Hackathon. Some essential elements like user tracking and authentication
have not yet been integrated, but code and database models already in use within
Macrostrat will be adapted for this purpose.

## Geologic entity canonicalization

We have continued to develop a pipeline for geological entity canonicalization
from the literature, based on xDD and both transformer- and LLM-based graph
construction approaches. The overall pipeline is described in the
[`macrostrat-xdd`][gh:macrostrat-xdd] repository, and the modeling approaches
are described in the [`llm-kg-generator`][gh:llm-kg-generator] codebase and the

It has become apparent that one of the challenges holding back the system has
been the lack of granular training data at the paragraph level, which has made
evaluating recall and precision difficult. Progress during this period has been
focused on building a more integrated modeling pipeline that encompasses both
approaches and adds results directly to the Macrostrat database for
visualization. In tandem, we have begun developing a

![Entity canonicalization pipeline design](./images/entity-canonicalization-pipeline.jpg)

# Expected capabilities of Phase 1 system

A system that can be run using `macrostrat up` in a Docker compose environment.

# Gaps

## Structurally complete products from TA1

Macrostrat's map ingestion systems have in the past been focused on
high-quality, vetted map products with all necessary elements (i.e., points,
lines, and polygons). Currently, TA1 output has not been synthesized across
teams and problem domains; for instance, projected data is not easily available
through the CDR. Jataware is working on this, but it has held up progress on
integrating TA1 mapping products and will likely be a program pain point in the
future.

## Integration with TA2

We have struggled to understand the expectations and obligations for user
interface development for TA2, especially in light of the shifting design of the
CDR. On the data system side, we have already developed components that turned
out to be of little use to the program (e.g., the [document
store][document-store] and [TA1 Geopackage Format](ta1-geopackage)) and are
reluctant to explore too deeply in directions that will be superseded by
Jataware-originated designs. We have begun to discuss this problem with Jataware
and others, and we anticipate that the month 9 Hackathon will be a good
opportunity to make progress on specific plans around the development of HITLs
themselves (not just CDR schemas). This is required to enable us to dedicate
resources to these UI construction tasks if necessary.

# Integration plans for the end of Phase 1

[gh:criticalmaas]: https://github.com/UW-Macrostrat/CriticalMAAS
[gh:macrostrat]: https://github.com/UW-Macrostrat/macrostrat
[ta1-geopackage]: https://github.com/DARPA-CRITICALMAAS/ta1-geopackage
[document-store]: https://github.com/UW-xDD/document-store
[cosmos]: https://github.com/UW-COSMOS/COSMOS
[mapboard_platform]: https://github.com/Mapboard/mapboard-platform
[gh:topology-manager]: https://github.com/Mapboard/topology-manager
[gh:python_libraries]: https://github.com/UW-Macrostrat/python-libraries
[gh:web_components]: https://github.com/UW-Macrostrat/web-components
[mapboard-gis]: https://mapboard-gis.app
[phase1_plan]:
  https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2023-10-CriticalMAAS-Phase-1-research-plan.pdf
[milestone_3_report]:
  https://storage.macrostrat.org/web-assets/media/criticalmaas/media/2024-02-CriticalMAAS-Milestone-3-report.pdf
[milestone_3_report]:
  https://storage.macrostrat.org/web-assets/criticalmaas/media/2024-04-CriticalMAAS-Milestone-4-report.pdf
[readme]: https://github.com/UW-Macrostrat/CriticalMAAS/blob/main/README.md
[gh:macrostrat_api]: https://github.com/UW-Macrostrat/macrostrat-api
[gh:macrostrat_api_v3]: https://github.com/UW-Macrostrat/api-v3
[gh:tileserver]: https://github.com/UW-Macrostrat/tileserver
[lawley2023]: https://doi.org/10.1007/s11053-023-10216-1
[poplar]: https://github.com/synyi/poplar
[gh:macrostrat-xdd]: https://github.com/UW-Macrostrat/macrostrat-xdd
[gh:llm-kg-generator]:
  https://github.com/UW-Macrostrat/llm-kg-generator/tree/pipeline
[gh:macrostrat_client]: https://github.com/DARPA-CRITICALMAAS/macrostratpy
