all:
	cat milestone-6-report.md | \
	pandoc -s \
		--metadata-file meta.yaml \
		-f markdown \
		--filter pandoc-crossref \
		--pdf-engine=xelatex \
		-o Macrostrat-CriticalMAAS-Milestone-6-report.pdf \
		-