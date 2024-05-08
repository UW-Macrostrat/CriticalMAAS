all:
	cat milestone-5-report.md | \
	pandoc -s \
		--metadata-file meta.yaml \
		-f markdown \
		--filter pandoc-crossref \
		--pdf-engine=xelatex \
		-o Macrostrat-CriticalMAAS-Milestone-5-report.pdf \
		-