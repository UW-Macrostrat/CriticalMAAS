all:
	cat milestone-4-report.md | \
	pandoc -s \
		--metadata-file meta.yaml \
		-f markdown \
		--filter pandoc-crossref \
		--pdf-engine=xelatex \
		-o ../../media/2024-04-CriticalMAAS-Milestone-4-report.pdf \
		-