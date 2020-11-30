#!/bin/bash
aws cloudformation deploy --template-file ../../src/database/rds-postgresql-template.yml \
--stack-name rds-postgresql-$RANDOM \
--parameter-overrides file://parameter-overrides.json \
--tags Environment=Development