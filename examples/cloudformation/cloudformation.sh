#!/bin/bash

########################################################################################################################
########################################### Deploy Cloudformation Stack ################################################
########################################################################################################################

aws cloudformation deploy \
  --stack-name "INSERT_STACK_NAME" \
  --template-file "INSERT_CLOUDFORMATION_FILE" \
  --parameter-overrides file://"INSERT_PARAMETERS_FILE" \
  --s3-bucket "INSERT_S3_BUCKET" \
  --region "$REGION" \
  --capabilities CAPABILITY_NAMED_IAM \
  --profile "$AWS_PROFILE"