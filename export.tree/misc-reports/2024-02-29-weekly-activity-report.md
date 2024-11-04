---
title: "CriticalMAAS Weekly Activity Report – UW-Madison/Macrostrat team"
date: "February 29, 2024"
---

# Macrostrat

## What we did

At the hackathon, we rapidly added geologic maps to the Macrostrat global
geologic data system using a prototype bulk ingestion pipeline. The provision of
geologic maps in a standardized, API-accessible format enables software
capabilities (e.g., web visualizations, modeling tools) to draw on a
standardized, consistently attributed geologic datasets, including a unified
view of many maps integrated into a single product.

## How good

To measure our progress, we can examine the number of geologic maps staged into
the Macrostrat data environment and made available using the Macrostrat API.
Staging each maps has three broad stages:

1. Bringing a map into Macrostrat's relational database and stabilizing table
   structure
2. Data validation and elevation to a "final" map (at which point the map
   becomes API-available)
3. Topological harmonization into Macrostrat's unified, multi-scale map
   compilation

Prior to the start of the CriticalMAAS program, Macrostrat had ingested 295
geologic map datasets since the system's inception in 2016. Bulk map ingestion
allows the rate of map acquisition to be greatly increased. In month 5-6 of
CriticalMAAS, the prototype bulk ingestion system came online and was tested

- 33 maps that were manually acquired from NGMDB were brought to "stage 2" (API
  availability)
- 8 maps from NGMDB were acquired using an automated pipeline and brought to
  "stage 1"
- 45 maps from Nevada Bureau of Mines and Geology were brought into the system.
  In addition to ingesting professionally-compiled map datasets, the pipeline
  was validated for CriticalMAAS TA1 outputs that follow the "Geopackage schema"
  designed by Macrostrat. This approach was validated at the hackathon, with 45
  TA1 outputs ingested to "stage 1." Four maps were selected to bring to "stage
  2" (API availability), demonstrating the pipeline's viability.

Bringing over 100 maps into Macrostrat's ingestion pipeline in less than an
month is a clear enhancement of our capability to assimilate mapping. This
prototype pipeline still has several limitations that we are working to address:

- The process of bringing data to Phase 2 (API availability) still entails
  manual touch points
- Phase 3 map harmonization into a unified product is run as a batch over all
  Macrostrat maps, leading to scaling issues as new maps are rapidly added

Macrostrat's map pipeline is one of the only systems to dynamically harmonize
the structure and representation of geologic maps at scale and represent the
result as an API-addressible product. Other unified map compliations, such as
the USGS's State Geological Map Compilation, are static products rather than
extensible systems. Thus, Macrostrat's map system already represents the state
of the art; its APIs are in wide use in web interfaces, Rockd and other mobile
apps, and analytical pipelines. Speeding up the ingestion of maps into this
framework enhances this already-formidable system. This potentially allows
thousands of geologic maps, including quad-scale vector mapping from NGMDB and
state surveys, and TA1-digitized legacy mapping, to enter the system, a great
increase in capability for ingesting large amounts of maps.

## Who cares

The result of CriticalMAAS will be a Macrostrat system under USGS control. The
already-extensive capabilities of this platform to represent a unified mapping
product will be enhanced with large amounts of new mapping compiled during
CriticalMAAS using a mostly-automated, HITL pipeline. This will allow an
authoritative, dynamically updatable mapping compilation to be assembled from
USGS mapping; this compilation can then be referenced as a single mapping
product for the purposes of modeling, visualization, and analysis. The ability
to reference many maps (currently, over 300 and growing rapidly) in a single
structure and multiscale product will remove many per-map data manipulation
steps from prospectivity-modeling workflows, saving substantial analyst time.

# xDD and the CriticalMAAS document store

## What we did

xDD is a machine-reading system that enables ML workflows over the scientific
literature, with over 17 million documents accessible. However, due to licensing
limitations for most scientific documents, workflows must be run as on-premises
batches. CriticalMAAS relies largely on openly-licensed documents compiled by
the USGS, allowing more capabilities to be exposed over the documents; TA2 needs
to access full document context in order to validate their ML workflows, and for
contextualized feedback to be linkable back to the source of information. In
order to enable full-document workflows in addition to CriticalMAAS, we built a
new **CriticalMAAS document store** to store program documents. Documents are
linked where applicable to xDD IDs and USGS GeoKB identifiers. This allows xDD
services to be linked to a program-managed store of full-text documents and (in
the future) categorized page extractions such as figures, tables and maps.

## How good

The key metric for the document store at this point in the program is the number
of documents stored in the system and available to program tools and workflows.
The document store now contains 78,461 documents that were designated by USGS to
be relevant to CriticalMAAS, including all publications in the USGS publications
warehouse, a collection of mining reports indexed by GeoKB, and other documents
that have been identified by USGS workers and ingested. While this is far fewer
documents than indexed by xDD as a whole, the provision of full document
contents via an API is a clear advance over previous capabilities.

While all documents in the document store are accessible to the USGS through its
own systems, the Document Store provides state-of-the-art unified search and
API-addressible capabilities to find and reference documents. Notably, these
capabilities have been used to provide access via Jataware's _Silk_
georeferencer; they will also be made available through other tools.

Some xDD-provided services are also accessible over the document store; notably,
the COSMOS pipeline has been used to extract 1.78 M entities (figures, tables,
body text, reference text, etc.) for a subset of 6,146 documents in the COSMOS
pipeline. These extractions are API-accessible, referenced to the document
store, and useful for quickly finding tables and figures relevant to specific
mineral systems and data compilation tasks.

An API-accessible system to manage program documents is a new development that
brings state-of-the-art xDD document management capabilities to a
program-managed system. This is a clear benefit to document search, tracking,
interchange, and access for critical minerals research.

## Who cares

The USGS, who will manage the document store as part of the CriticalMAAS
transition, will have an API-accessible tool to manage public and private
documents through a unified interface. This tool will serve a variety of HITL
tools under development by TA4 (notably right now, Jataware's Silk
georeferencer) that will streamline access to program documents, potentially
speeding reference and assessment workflows by an order of magnitude at least.
This system is already accessible for 78,461 documents and more will be added as
designated by USGS.
