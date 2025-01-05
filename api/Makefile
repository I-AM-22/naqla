## Variables ##

MIGRATIONS_FOLDER := src/database/migrations
DATA_SOURCE_PATH := src/database/data-source.ts
DOTENV_PATH := dotenv/config
TYPORM_EXTENSION_PATH := ./node_modules/typeorm-extension/bin/cli.cjs
DATA_BASE_CONFIG := src/config/database/postgres
TS_CONFIG := tsconfig-paths/register
CMD :=
EXTRA_ARGS :=
NAME :=

install: package.json
	yarn install

build:
	npx @nestjs/cli build

run:
	nest start

develop:
	nest start --watch

debug:
	nest start --debug --watch

prod: build
	ENV=production node dist/main

format:
	npx prettier --write "src/**/*.ts" "test/**/*.ts"

format-check:
	npx prettier --check .

lint-code:
	npx eslint --ext ts .

lint: lint-code format-check

lint-fix:
	npx eslint "{src,apps,libs,test}/**/*.ts" --fix

typeorm:
	npx env-cmd ts-node -r ${TS_CONFIG} ./node_modules/typeorm/cli.js  --dataSource=${DATA_SOURCE_PATH} ${CMD}

migration-generate:
	@echo "Generating new migration..."
	make typeorm  CMD="migration:generate ${MIGRATIONS_FOLDER}/${NAME}"

migrations-run:
	@echo "Running migrations..."
	make typeorm CMD="migration:run"


migration-revert: 
	@echo "Reverting latest migration..."
	make typeorm CMD="migration:revert"

redis-up:
	docker compose up -d redisqueue

redis-rm:
	docker compose rm -s -f -v redisqueue

redis-restart:
	make redis-rm && make redis-up

db-up:
	docker compose up -d dev-db

db-rm:
	docker compose rm -s -f -v dev-db

db-restart:
	make db-rm && make db-up

db-rq-up:
	make db-up && make redis-up

db-rq-rm:
	make db-rm && make redis-rm

db-rq-restart:
	make db-redis-rm && make db-redis-up

docker-stop:
	docker compose stop

typeorm-extension:
	npx env-cmd ts-node -r ${DOTENV_PATH} ${TYPORM_EXTENSION_PATH} ${CMD} -r ${DATA_BASE_CONFIG} ${EXTRA_ARGS}

db-create:
	make typeorm-extension CMD="db:create" EXTRA_ARGS="--initialDatabase=postgres"

db-drop:
	make typeorm-extension CMD="db:drop" EXTRA_ARGS="--initialDatabase=postgres" 

db-seed-fake:
	make typeorm-extension CMD="seed:run"

db-seed-create:
	make typeorm-extension CMD="seed:create" EXTRA_ARGS="--name src/database/seeders/${NAME}/${NAME}.seeder.ts"

db-seed-real:
	npx env-cmd ts-node -r ${TS_CONFIG} src/seed.ts

db-seed-prod:
	ENV=production npx ts-node -r ${TS_CONFIG} src/seed.ts

db-seed:
	make db-create && make db-seed-real && make db-seed-fake

doc-generate:
	npx compodoc -p tsconfig.doc.json -s

doc-run:
	npx compodoc -s

.PHONY: install
.PHONY: test
.PHONY: build
.PHONY: pre-build
.PHONY: run
.PHONY: develop
.PHONY: prod
.PHONY: debug
.PHONY: format
.PHONY: format-check
.PHONY: lint-code
.PHONY: lint
.PHONY: migration-generate
.PHONY: migration-revert
.PHONY: migrations-run
.PHONY: typeorm
.PHONY: redis-up
.PHONY: redis-rm
.PHONY: redis-restart
.PHONY: db-up
.PHONY: db-rm
.PHONY: db-restart
.PHONY: db-rq-up
.PHONY: db-rq-rm
.PHONY: db-rq-restart
.PHONY: typeorm-extension
.PHONY: db-create
.PHONY: db-drop
.PHONY: db-seed-real
.PHONY: db-seed-fake
.PHONY: db-seed-create
.PHONY: db-create-prod
.PHONY: db-seed
.PHONY: doc-generate
.PHONY: doc-run


