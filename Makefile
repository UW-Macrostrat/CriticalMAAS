all:
	scripts/fetch-documents.sh

sync:
	git annex sync --content -A web-assets