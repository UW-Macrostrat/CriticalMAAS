all:
	cat 2024-02-29-weekly-activity-report.md | \
	pandoc -s \
		--metadata-file meta.yaml \
		-f markdown \
		--filter pandoc-crossref \
		--pdf-engine=xelatex \
		-o Macrostrat-CriticalMAAS-2024-02-29-weekly-activity-report.pdf \
		-