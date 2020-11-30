#!/bin/bash
aws cloudformation deploy --template-file ../../src/pipeline/pipeline-template.yml \
--stack-name rds-postgresql-devops-$RANDOM \
--tags Environment=Development