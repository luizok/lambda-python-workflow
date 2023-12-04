app_path = app
test_cmd = dotenv run pytest -v --rootdir=$(app_path)

run:
	dotenv run python $(app_path)/main.py

test:
	$(test_cmd)

isort:
	dotenv run python -m isort

lint:
	dotenv run flake8 $(app_path)

coverage:
	$(test_cmd) --cov=. \
	--cov-report=html:out/tests/htmlcov \
	--cov-report=xml:out/tests/coverage.xml \
	--cov-fail-under=90 \
	--cov-config=.coveragerc

clean:
	find . | grep -E "(__pycache__|.pytest_cache)$$" | xargs rm -rf

clean-coverage:
	find . | grep -E "(htmlcov|coverage.xml|.coverage)$$" | xargs rm -rf
