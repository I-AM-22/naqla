## Variables ##

KNEX := ./node_modules/knex/bin/cli.js
KNEXFILE := ./dist/src/config/knexfile.js
KNEXFILE_TS := ./src/config/knexfile.ts

BOOTSTRAP := ./dist/src/bootstrap.js

# You can define your local flags for Vitest here and they will be added to the Vitest command.
VITEST_OVERRIDES := --coverage

# If you want to enable Node.js debugger, uncomment the following line:
# export RUN_OPTIONS=--inspect=0.0.0.0:9222

## Rules ##

compile:
	rm -rf dist
	npx tsc -p ./tsconfig.build.json

compileWindows:
	if exist dist rd /s /q dist
	set PATH=C:\Program Files\nodejs;$(PATH) && npx tsc -p tsconfig.build.json

install: package.json
	yarn install

install-ci: package.json package-lock.json
	npm ci

test: reset-test-db
	NODE_ENV=test npx vitest --run ${VITEST_OVERRIDES}

test-docker:
	docker compose -f compose.test.yml run --build --rm --name test-api api

test-update: reset-test-db
	NODE_ENV=test npx vitest --run --update ${VITEST_OVERRIDES}

test-watch: reset-test-db
	NODE_ENV=test npx vitest --watch ${VITEST_OVERRIDES}

test-coverage: reset-test-db
	NODE_ENV=test npx vitest --run --coverage ${VITEST_OVERRIDES}

run: compile
	node -r $(BOOTSTRAP) ${RUN_OPTIONS} ./dist/src/cluster.js | npx pino-pretty

run-docker:
	COMPOSE_PROFILES=prod docker compose run --build --rm --service-ports --name api api

develop:
	nest start --watch

develop-docker:
	COMPOSE_PROFILES=dev docker compose run --build --rm --service-ports --name api api

format:
	npx prettier --write .

format-check:
	npx prettier --check .

lint-code:
	npx eslint --ext ts .

lint: lint-code format-check

lint-fix:
	npx eslint --ext ts . --fix

migrate: compile
	node -r $(BOOTSTRAP) $(KNEX) migrate:latest --knexfile=$(KNEXFILE)

create-migration:
	node -r $(BOOTSTRAP) $(KNEX) migrate:make $(NAME) --knexfile=$(KNEXFILE_TS)

rollback: compile
	node -r $(BOOTSTRAP) $(KNEX) migrate:rollback --knexfile=$(KNEXFILE)

reset-test-db: compile
	NODE_ENV=test node -r $(BOOTSTRAP) $(KNEX) migrate:rollback --knexfile=$(KNEXFILE)
	NODE_ENV=test node -r $(BOOTSTRAP) $(KNEX) migrate:latest --knexfile=$(KNEXFILE)

reset-dev-db: compile
	node -r $(BOOTSTRAP) $(KNEX) migrate:rollback --knexfile=$(KNEXFILE)
	node -r $(BOOTSTRAP) $(KNEX) migrate:latest --knexfile=$(KNEXFILE)

reset-dev-db-seed: reset-dev-db
	node -r $(BOOTSTRAP) $(KNEX) seed:run --knexfile=$(KNEXFILE)

infra:
	docker compose up -d --force-recreate

infra-stop:
	docker compose stop

.PHONY: compile
.PHONY: install
.PHONY: install-ci
.PHONY: test
.PHONY: test-docker
.PHONY: test-update
.PHONY: test-watch
.PHONY: test-coverage
.PHONY: run
.PHONY: run-docker
.PHONY: develop
.PHONY: develop-docker
.PHONY: format
.PHONY: format-check
.PHONY: lint-code
.PHONY: lint
.PHONY: migrate
.PHONY: rollback
.PHONY: reset-test-db
.PHONY: reset-dev-db
.PHONY: reset-dev-db-seed
.PHONY: infra
.PHONY: infra-stop
