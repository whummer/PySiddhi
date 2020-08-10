VENV_DIR ?= .venv
VENV_RUN = . $(VENV_DIR)/bin/activate
PIP_CMD ?= pip

usage:        ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

setup-venv:
	(test `which virtualenv` || $(PIP_CMD) install --user virtualenv) && \
		(test -e $(VENV_DIR) || virtualenv $(VENV_OPTS) $(VENV_DIR))

install:      ## Install full dependencies in virtualenv
	make setup-venv && ($(VENV_RUN); $(PIP_CMD) -q install -r requirements.txt)

publish:      ## Publish the library to the central PyPi repository
	# build and upload archive
	($(VENV_RUN) && python ./setup.py sdist upload)

.PHONY: usage install publish
