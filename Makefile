app_path = app
infra_path = infra/
test_cmd = dotenv run pytest -v --rootdir=$(app_path)
tf_cmd = dotenv run terraform -chdir=$(infra_path)

run:
	dotenv run python $(app_path)/lambda_function.py

test:
	$(test_cmd)

isort:
	dotenv run python -m isort $(app_path)/**/*.py

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

init:
	$(tf_cmd) init -backend-config config.aws.tfbackend

reinit:
	$(tf_cmd) init -reconfigure -backend-config config.aws.tfbackend

validate:
	$(tf_cmd) fmt
	$(tf_cmd) validate

plan:
	$(tf_cmd) plan -var-file values.tfvars

deploy:
	$(tf_cmd) apply -var-file values.tfvars

show:
	$(tf_cmd) show

destroy:
	$(tf_cmd) destroy -var-file values.tfvars
