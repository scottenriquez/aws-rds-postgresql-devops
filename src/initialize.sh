#!/bin/bash
set -e
ARTIFACT_NAME=artifact.zip
S3_STAGING_BUCKET_NAME=rds-postgresql-devops-staging-$RANDOM
aws cloudformation deploy --template-file pipeline/staging-bucket-template.yml \
--stack-name rds-postgresql-devops-staging-$RANDOM \
--parameter-overrides pStagingBucketName=$S3_STAGING_BUCKET_NAME \
--tags Environment=Production
zip -r -X $ARTIFACT_NAME .
aws s3 cp artifact.zip s3://$S3_STAGING_BUCKET_NAME/$ARTIFACT_NAME
rm $ARTIFACT_NAME
aws cloudformation deploy --template-file pipeline/pipeline-template.yml \
--stack-name rds-postgresql-devops-pipeline-$RANDOM \
--parameter-overrides pStagingBucketName=$S3_STAGING_BUCKET_NAME pStagingArtifactKey=$ARTIFACT_NAME \
--tags Environment=Production \
--capabilities CAPABILITY_NAMED_IAM