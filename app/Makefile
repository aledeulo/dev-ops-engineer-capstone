setup:
	# Create python virtualenv & source it
	python3 -m venv .devops &&\
	. .devops/bin/activate

install:
	# This should be run from inside a virtualenv
	pip install --upgrade --no-cache-dir pip &&\
		pip install --no-cache-dir -r requirements.txt

test:
	python -m pytest -vv --cov=. app_test.py

lint:
	# Install hadolint
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
	chmod +x /bin/hadolint

	hadolint Dockerfile
	pylint --disable=R,C,W1203,W1202 app.py

all: install lint test