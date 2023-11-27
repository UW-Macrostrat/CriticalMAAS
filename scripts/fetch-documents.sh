#!/usr/bin/env bash

# This script fetches the documents from S3 and saves them in the documents folder

s3_bucket="https://s3.macrostrat.chtc.io/web-assets/media/criticalmaas/"

documents=(
  2023-08-CriticalMAAS-kickoff-slides.pdf 
  2023-08-CriticalMAAS-UW-whitepaper.pdf
  2023-10-CriticalMAAS-Phase-1-research-plan.pdf
)

mkdir -p documents

for document in "${documents[@]}"
do
  outfile="documents/$document"
  [ -f $outfile ] && continue
  wget -O $outfile $s3_bucket$document
done