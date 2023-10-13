all:
	cat phase-1-research-plan.md | \
	scripts/prepare-crossref | \
	pandoc -s \
		--metadata-file meta.yaml \
		--filter pandoc-crossref \
		--pdf-engine=xelatex \
		-o phase-1-research-plan.pdf \
		-