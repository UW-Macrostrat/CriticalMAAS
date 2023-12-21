# UW-Macrostrat CriticalMAAS

Project overviews, roadmaps and milestone reports for Macrostrat's contribution
to the DARPA/USGS CriticalMAAS program.

## Project documents

Compiled documents are stored in a S3 and linked to below. To download all
documents, run `make`.

- [Project whitepaper](https://s3.macrostrat.chtc.io/web-assets/criticalmaas/media/2023-08-CriticalMAAS-UW-whitepaper.pdf)
  _(August 2023)_: A trimmed-down version of the proposal, detailing goals and
  potential deliverables.
- [Kickoff slides](https://s3.macrostrat.chtc.io/web-assets/media/criticalmaas/media/2023-08-CriticalMAAS-kickoff-slides.pdf)
  _(August 2023)_: A brief overview of the Macrostrat platform and goals,
  presented by PI Daven Quinn at the kickoff meeting.
- [Phase 1 research plan](https://s3.macrostrat.chtc.io/web-assets/criticalmaas/media/2023-10-CriticalMAAS-Phase-1-research-plan.pdf)
  _(October 2023)_: A detailed plan for the first phase of the project,
  including a timeline and deliverables.

Run `make` in the root directory of this repository to download all documents.

## Software repositories

This is an index of the software repositories that are or may be contributed to
as part of the Macrostrat CriticalMAAS effort.

### Macrostrat core system

- [`UW-Macrostrat/macrostrat`](https://github.com/UW-Macrostrat/macrostrat):
  Macrostrat's core system, including its database definitions and control
  scripts.
- [`UW-Macrostrat/tileserver`](https://github.com/UW-Macrostrat/tileserver):
  Server for vector and raster tiles to GIS software
- [`UW-Macrostrat/tiger-macrostrat-config`](https://github.com/UW-Macrostrat/tiger-macrostrat-config):
  Macrostrat onfiguration for CHTC infrastructure (_private, due to its tight
  integration with UW–Madison CHTC systems_)
- [`UW-Macrostrat/web`](https://github.com/UW-Macrostrat/web): Macrostrat's main
  web interface

### Program integration

- [`DARPA-CRITICALMAAS/schemas`](https://github.com/DARPA-CRITICALMAAS/schemas):
  Schemas for TA1-3 integrations (_initiated by UW-Macrostrat team; now shared
  among all performers_)
- [`UW-Macrostrat/criticalmaas`](https://github.com/UW-Macrostrat/criticalmaas):
  Index repository for Macrostrat's CriticalMAAS project documents
- [`UW-Macrostrat/macrostrat-xdd`](https://github.com/UW-Macrostrat/macrostrat-xdd):
  xDD integration for geologic entity characterization

### Shared libraries

- [`UW-Macrostrat/web-components`](https://github.com/UW-Macrostrat/web-components):
  Shared user interface components for Macrostrat user interfaces
- [`UW-Macrostrat/python-libraries`](https://github.com/UW-Macrostrat/python-libraries):
  Python libraries used in multiple applications (@sec:map-integration)

### Data pipeline components

These repositories contain data pipeline components in early development. Their
organization is subject to change as systems develop (some similar components
have already been merged into the
[`UW-Macrostrat/macrostrat`](https://github.com/UW-Macrostrat/macrostrat)
repository).

- [`UW-Macrostrat/raster-cli`](https://github.com/UW-Macrostrat/raster-cli):
  Prototype tool for ingesting raster datasets
- [`DigitalCrust/weaver`](https://github.com/digitalcrust/weaver): Curation and
  ingestion of geological site datasets
- [`Mapboard/topology-manager`](https://github.com/Mapboard/topology-manager):
  Topological map editing

### Other repositories

#### Repositories integrated into [`UW-Macrostrat/macrostrat`](https://github.com/UW-Macrostrat/macrostrat)

These repositories are not currently being actively developed, having been
integrated into Macrostrat's core system.

- [`UW-Macrostrat/map-integration`](https://github.com/UW-Macrostrat/map-integration):
  Geologic map ingestion and harmonization
- [`UW-Macrostrat/cli`](https://github.com/UW-Macrostrat/cli): Macrostrat system
  management tools

#### Document extraction handling

These document handling repositories are maintained as part of the
[xDD](https://xdd.wisc.edu/) system, and will be called on as necessary for the
CriticalMAAS project.

- [`UW-COSMOS/cosmos-visualizer`](https://github.com/UW-COSMOS/cosmos-visualizer):
  Page annotation and feedback
- [`UW-COSMOS/COSMOS`](https://github.com/UW-COSMOS/COSMOS): PDF entity
  extraction pipeline

## Documentation

- [`macrostrat` CLI documentation](https://github.com/UW-Macrostrat/macrostrat/blob/main/macrostrat-cli/docs/cli-usage.md):
  The management interface for Macrostrat's schemas and data ingestion system.

## Project Milestones

### Phase 1

| #   | Milestone                                                                                                                                              | Exit Criteria         | Target Date | Product |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------- | ----------- | ------- |
| 0   | [Specifications for TA 1-3](https://github.com/DARPA-CRITICALMAAS/schemas)                                                                             | Specifiation Plans    | 09/2023     |         |
| 1   | [Detailed research plan for Phase 1](https://s3.macrostrat.chtc.io/web-assets/media/criticalmaas/media/2023-10-CriticalMAAS-Phase-1-research-plan.pdf) | Milestone Report      | 10/2023     |         |
| 2   | [Initial code/documentation release](https://s3.macrostrat.chtc.io/web-assets/media/criticalmaas/media/2023-12-CriticalMAAS-Milestone-2-report.pdf)    | Milestone Report/Code | 12/2023     |         |
| 3   | Report detailing progress of research and technology and gaps                                                                                          | Milestone Report      | 02/2024     |         |
| 4   | Code/documentation/data release                                                                                                                        | Milestone Report/Code | 03/2024     |         |
| 5   | Report detailing progress, capabilities, gaps, and final integration plans                                                                             | Milestone Report      | 04/2024     |         |
| 6   | Report with challenge evaluation results, working code and documentation and end-to-end integration                                                    | Milestone Report/Code | 07/2024     |         |
