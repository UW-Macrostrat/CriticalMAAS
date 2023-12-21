# Proposal—Full-PDF API to supplement xDD services

This proposed service provides full-document context over a set of PDFs stored
in a document store. It responds to needs of CriticalMAAS program for designing
workflows linking machine-reading capabilities with human evaluation and
verification, over large sets of internal documents.

The system will serve a key role as a PDF document store component of the
"CriticalMAAS Data Repository". It will also fill a more general capability gap
for linking xDD to external workflows that can be relevant outside of
CriticalMAAS.

The APIs atop this store will provide:

- A standardized data service for accessing PDF document sets for ML pipeline
  development
- Contextual page snippets of PDFs for use in _"human-in-the-loop"_ applications

The system will be integrated with xDD capabilities for search, discovery, and
filtering (e.g.,
[the xDD snippets API](https://xdd.wisc.edu/api/snippets?term=Belle%20Fourche%20Formation&set=dolomites))
but will be a service that can be managed separately (e.g., by USGS as part of
the CriticalMAAS program). Links can be followed from this system to xDD, but
not the other way around. **xDD will not provide or integrate capabilities for
accessing full-text documents as part of its core services.**

## Access control

> [!warning] Copyright safety This application will provide full text access to
> PDFs, which is often reserved to the original publisher. It is designed for
> internal use for testing and validation, except in unusual cases where all
> documents can be verified to be in the public domain.
>
> **Attestation that document access follows legal requirements** is the
> responsibility of the maintainer of the PDF document store, not xDD. When
> legal obligations preclude such access, or are ambiguous, xDD core services
> should be used without this application.

### Document store

Access to PDFs should be controlled at the document store level. Each document
store must contain only PDFs with copyright status appropriate to its level of
public access. Examples:

- A public S3 bucket for documents that we know are in the public domain
- A secure S3 bucket with "USGS internal" access for work products associated
  with CriticalMAAS with more ambiguous copyright (e.g., `geoarchive` set, or
  some subset of that)

### API layer

- In general, API access controls will require access limitations corresponding
  to those for the document PDFs (except for metadata routes, which will have
  only basic information).
- This will require additional API-level access controls (ex., API keys or
  passwords) to limit access to the system

## Components

- **Document store**: An unstructured set of PDF documents (usually, a S3
  bucket)
- **Metadata database and API**: PDF link, xDD ID and other metadata, source
  document link, page counts and sizes
- **Page snippet API**: Cosmos-style extractions to provide page bounding boxes
  and context to web applications

A stable ID to each document will need to be defined, which we hope can mirror
an xDD ID in many cases (this would obviously not be possible if documents were not
contained in xDD).

> [!todo] OCR text, ElasticSearch, and other services
> Providing access and search over the OCR text layer of PDFs
> will require significant backend infrastructure beyond a simple collection of
> PDFs, but it might be worthwhile to drive certain extraction tasks.

## Proposed API structure

### Metadata

- `/documents`: List all documents in the store (+pagination, etc.)
- `/document/<stable-id>`: Document metadata for an individual document

### Full-text PDFs

- `/document/<stable-id>.pdf`: The full-text PDF associated with an xDD ID

### Page extraction images

- `/document/<stable-id>/page/<n>.{pdf|webp}`: Page PDF thumbnail
- `/document/<stable-id>/page/<n>/<x1>,<y1>,<x2>,<y2>.{pdf|webp}`: A windowed page
  thumbnail
- Images should be dynamically generated with caching as appropriate

## Usage

### Typical application flow

- Documents with full-text PDFs available can be listed
- Clients should integrate with xDD's API for search and discovery capabilities
- No documents in an xDD set is guaranteed to be part of a full-text document
  store
- _Applications should fail gracefully for documents where full-text PDFs cannot
  be found._

### Working with documents not in xDD

If PDF context is desired for documents not in xDD, the ideal approach will be
to integrate with the "bring your own documents" flow currently being tested by
xDD (November 2023). So new documents would be added to xDD and their full-text
contents retained in this system, in tandem.

However, for fully independent operation, it might be desirable to allow documents
not in xDD to be tracked by this system. In that case, it remains an open question
how many services provided by xDD (e.g., OCR processing, ElasticSearch) should be
replicated in this framework.

> [!todo] A staging area for xDD ingestion?
> If this store contained documents not in xDD, this application could
> serve as a "staging area" for bringing documents into the system, if the
> metadata database contained the requisite information (e.g., citations, links to the source) for
> successful ingestion into xDD.
