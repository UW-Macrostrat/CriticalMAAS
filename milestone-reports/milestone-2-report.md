# DARPA CriticalMAAS Milestone 2 Report

## Report period

This **Milestone 2** report covers UW-Madison – Macrostrat contributions to the
CriticalMAAS project for the period from October 13, 2023 through December 20,
2023 (Months 2-4).

## Code and documentation

The major deliverable for this milestone is code and documentation covering
Macrostrat's contribution to CriticalMAAS. Both of these components are indexed
in the [**UW–Macrostrat CriticalMAAS README**][readme] at the root of the the
[`UW-Macrostrat/CriticalMAAS`](https://github.com/UW-Macrostrat/CriticalMAAS)
GitHub repository.

### New codebases established in this milestone

The purpose and development plans for Macrostrat's codebases listed in that
document remain broadly aligned with our [Phase 1 Research Plan][phase1_plan].
However, some changes and additions have been made based on evolving project
structure and integrations with other teams, which we highlight here.

#### A unified code repository for Macrostrat core

The [`UW-Macrostrat/macrostrat`](https://github.com/UW-Macrostrat/macrostrat)
repository has been created to house the core of the Macrostrat system. This
codebase integrates formerly separate components into a unified representation
of Macrostrat's database schema, map ingestion pipelines, and geological data
integration infrastructure. This repository will form the core of the runnable
Macrostrat system that will be provided to USGS.

#### Infrastructure coordination with TA1-4 teams

The UW-Macrostrat team has led the development of several infrastructure
components for the CriticalMAAS program. These components have gained broad
agreement among stakeholders in other teams and represent key contributions to
the "CriticalMAAS Data Repository."

- [`DARPA-CriticalMAAS/ta1-geopackage`](https://github.com/DARPA-CRITICALMAAS/ta1-geopackage):
  a GeoPackage-based data format for validating and storing TA1 output
- [`UW-xDD/document-store`](https://github.com/UW-xDD/document-store): A
  supplemental store for public/user provided PDFs that provides full-text
  access, integrates with xDD APIs.
- [`DARPA-CriticalMAAS/schemas`](https://github.com/DARPA-CRITICALMAAS/schemas):
  A repository for schemas and data formats for TA1-3 integrations (_started by
  UW–Macrostrat and subsequently contributed to by all TA teams_)

#### Map unit characterization

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

### Documentation roadmap

The [**CriticalMAAS README**][readme] contains links to documentation for
Macrostrat services and software components relevant to CriticalMAAS, including
tutorials, example interfaces, and design documents.

Prior to the start of CriticalMAAS, Macrostrat's documention was largely
oriented to internal use; it remains minimally detailed and spread across a
variety of websites, API endpoints, and code repositories. In order for
Macrostrat to be usable by the USGS by the end of the CritialMAAS program, the
software platform must be made more approachable by a broader audience.
Macrostrat's history and complexity make this a challenging task, but we are
working to improve our overall documentation in several ways:

- We have created an
  [index of map layer inspectors](https://v2.macrostrat.org/map/dev) to
  demonstrate the capabilities of Macrostrat and its APIs, especially the tiled
  data formats that will be utilized to send geologic maps to TA3.
- We have created the
  [`UW-Macrostrat/docs`](https://github.com/UW-Macrostrat/docs) repository to
  store broad system documentation and improve discoverability and usability. We
  will build this resource over the coming months and publish it as
  [a documentation website](https://v2.macrostrat.org/docs).
- New Macrostrat APIs will be documented using the OpenAPI specification in
  order to conform to common standards.
- Documentation websites for
  [shared web components](https://github.com/UW-Macrostrat/web-components) and
  [Python libraries](https://github.com/UW-Macrostrat/python-libraries) will be
  established

## Technical accomplishments

We have made major progress on our core task for CriticalMAAS, developing a
pipeline for integrationg TA1 mapping data into a harmonized geologic product to
pass to TA3. Our progress has largely gone according to the [Phase 1 Research
Plan][phase1_plan], but here we summarize several notable accomplishments.

### Program alignment

Macrostrat has driven and participated in alignment efforts for CriticalMAAS
data systems and formats. These efforts have been focused on establishing
consistent data formats and schemas for TA1-3 data, and have resulted in several
notable achievements:

- At the November workshop, TA4 was able to demonstrate aligned and
  complementary components for georeferencing (Jataware), map curation
  (Macrostrat), and data alignment for TA3 (MTRI) that demonstrate the notional
  structure of a complete TA1-3 pipeline for geologic mapping data, supported by
  TA4.
- We've established a GeoPackage-based data format for TA1 data, which is
  documented in at
  [`DARPA-CriticalMAAS/ta1-geopackage`](https://github.com/DARPA-CriticalMAAS/ta1-geopackage)
- We've aligned with Jataware on core needs for tracking of raster geologic maps
  (source maps from NGMDB for TA1), and will use the data stores they are
  building
- We've aligned with Jataware on core needs for document storage and access for
  TA2. We will build the document store to support this system in the
  [`UW-xDD/document-store`](https://github.com/UW-xDD/document-store) repository
  and expect to receive contributions from Jataware.
- We have assisted MTRI with building and demonstrating an
  [initial evaluation](https://github.com/DARPA-CRITICALMAAS/mtri-ta4/blob/main/plugins/gidlac/dev/macrostrat/transform.py)
  that Macrostrat tiled mapping data and associated attributes can be used in
  their QGIS-based data preparation workflows for TA3.

Taken together, these integrations represent significant time spent on program
alignment, with good results. We expect that the detailed plans we have
established will speed our future development. These efforts also establish the
parameters of the _CriticalMAAS data repository_ as a distributed effort among
the teams.

### Macrostrat system integration

In creating the
[`UW-Macrostrat/macrostrat`](https://github.com/UW-Macrostrat/macrostrat)
repository, we have aligned and updated Macrostrat's codebase significantly to
support CriticalMAAS use cases. With this system, we've started building a
unified tool that can control Macrostrat across a distributed cloud
infrastructure. The core of this system is the `macrostrat` command-line tool,
which allows us to control Macrostrat data ingestion and evolve the system's
schemas. In the CHTC private cloud, we have validated the process of making
schema evolutions across the entire Macrostrat mapping database, and are now
working to improve Macrostrat's backend processing and data ingestion pipelines
to support the ingestion of TA1 data in January.

We will continue to build in this direction over the coming months in order to
support the ingestion of TA1 and TA2 data and the rapid evolution of Macrostrat
internals (especially around geologic attributes) that will be required to
support TA3.

### Paleogeography system

![Macrostrat paleogeographic map](https://private-user-images.githubusercontent.com/1537910/290287160-a840a148-8773-4ea4-b21e-9caf401cd772.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDMxMTc1OTMsIm5iZiI6MTcwMzExNzI5MywicGF0aCI6Ii8xNTM3OTEwLzI5MDI4NzE2MC1hODQwYTE0OC04NzczLTRlYTQtYjIxZS05Y2FmNDAxY2Q3NzIucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQUlXTkpZQVg0Q1NWRUg1M0ElMkYyMDIzMTIyMSUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyMzEyMjFUMDAwODEzWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9NDliM2M3M2MwY2Q2OGI1OGVkMmQ2MDUxMjQ3MTUzZDE4ZDkzMTU2YTVmMTNjMjBmMTQzMjc4MDIzZWVmODQ1YSZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QmYWN0b3JfaWQ9MCZrZXlfaWQ9MCZyZXBvX2lkPTAifQ.L0RnDmYWV2wADatCMPfCxlCP8GmH4guhUhn91na7GGE)

One technical achievement that is outside of the bounds of our CriticalMAAS
project plan but notably in-scope for the mineral systems analysis problem is
our development of a paleogeographic interface for Macrostrat geologic maps,
which is [nearing completion](https://github.com/UW-Macrostrat/web/issues/101).
This interface is the result of academic work on paleogeography since 2020 that
has converged at the right time to take advantage of Macrostrat's expanded
infrastructure footprint through the CriticalMAAS program. This interface, which
rotates all geologic maps in Macrostrat to a common paleogeographic reference
frame in Earth's past, is the first of its kind, and enables advanced spatial
and proximity analysis at any point in the past. This system has been useful to
validate the capabilities established through CriticalMAAS for manipulating
Macrostrat's database, and it will likely prove extremely valuable for the
minerals systems analysis problem (for instance, [Lawley et al,
2023][lawley2023] used paleogeography as a data layer, but this was based on a
much less capable GIS system).

# Issues or concerns

Our largest worry at the first milestone of the CriticalMAAS project was
establishing alignment with other teams, especially Jataware, to ensure that we
were not building duplicate functionality. Based on alignment work that has been
done over the past two months, we feel we have solved this issue definitively
and are working in complementary and coordinated directions.

Our biggest concern at this point is that we can produce a pipeline to ingest
TA1 data rapidly enough to keep up with incoming data. The only solution to this
is for us to focus internally on our infrastructure and data pipelines for map
integration, and this is what we plan to do for the next few months.

Looking forward, we expect that the next major challenge will be coordinating
TA1 and TA2 teams, alongside new user interfaces, to deliver the requisite
quality of geologic metadata to build a harmonized geologic mapping product for
TA3. This will require significant geological expertise to be applied, so we
will need to work closely with the USGS to establish a process and clear
expectations for this work, so that the geological elements of the project
(Macrostrat and the USGS) can communicate a clear and unified set of
requirements to the TA1 and TA2 teams.

[readme]: https://github.com/UW-Macrostrat/CriticalMAAS/blob/main/README.md
[phase1_plan]:
  https://s3.macrostrat.chtc.io/web-assets/media/criticalmaas/2023-10-CriticalMAAS-Phase-1-research-plan.pdf
[lawley2023]: https://doi.org/10.1007/s11053-023-10216-1

## Appendix: Progress towards established technical plan

In addition to the specific advances highlighted above, we are making progress
towards the broad technical tasks outlined in our [Phase 1 Research
Plan][phase1_plan]. We have made significant progress towards our **Milestone
2** across all task areas:

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
