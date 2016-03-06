HUMILIS := .env/bin/humilis
PIP := .env/bin/pip
TOX := .env/bin/tox
STAGE := DEV
HUMILIS_ENV := tests/integration/firehose-rsc

# create virtual environment
.env:
	virtualenv .env -p python3.5

# install dev dependencies, create layers directory
develop: .env
	.env/bin/pip install -r requirements-dev.txt

# run unit tests
test: .env
	$(PIP) install tox
	$(TOX) -e unit

# remove .tox and .env dirs
clean:
	rm -rf .env .tox

# deploy the test environment
create:
	$(HUMILIS) create --stage $(STAGE) $(HUMILIS_ENV).yaml

# update the test deployment
update:
	$(HUMILIS) update --stage $(STAGE) $(HUMILIS_ENV).yaml

# delete the test deployment
delete:
	$(HUMILIS) delete --stage $(STAGE) $(HUMILIS_ENV).yaml
