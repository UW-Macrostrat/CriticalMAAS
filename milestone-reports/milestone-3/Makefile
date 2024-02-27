all:
	cat milestone-3-report.md | \
	pandoc -s \
		--metadata-file meta.yaml \
		-f markdown \
		--filter pandoc-crossref \
		--pdf-engine=xelatex \
		-o Macrostrat-CriticalMAAS-Milestone-3-report.pdf \
		-