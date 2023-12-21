#!/usr/bin/env bash

# This script fetches the documents from S3 and saves them in the documents folder

# If we have git-annex installed, we can use it to fetch the documents
if command -v git-annex &> /dev/null
then
  git annex enableremote web-assets
  git annex get --from web-assets media
  exit 0
fi

# The old-fashioned way without git-annex

s3_bucket="https://s3.macrostrat.chtc.io/web-assets"

documents=(
  2023-08-CriticalMAAS-kickoff-slides.pdf 
  2023-08-CriticalMAAS-UW-whitepaper.pdf
  2023-10-CriticalMAAS-Phase-1-research-plan.pdf
)

mkdir -p media

for document in "${documents[@]}"
do
  outfile="media/$document"
  [ -f $outfile ] && continue
  wget -O $outfile "$s3_bucket/criticalmaas/$outfile"
done