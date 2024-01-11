#!/bin/bash

########################################################################################################################
########################################## GET Cognito User Pool ID ####################################################
########################################################################################################################

COG_POOL_ID=$(aws cognito-idp list-user-pools \
    --max-results 20 \
    --profile "$AWS_PROFILE" \
    --region "$REGION" \
    | jq --raw-output | jq -r '.UserPools[] | select(.Name == "USER_POOL_NAME") | .Id')

########################################################################################################################
########################################### GET Cognito App Client ID ##################################################
########################################################################################################################

COG_CLIENT_ID=$(aws cognito-idp list-user-pool-clients \
    --user-pool-id "$COG_POOL_ID" \
    --profile "$AWS_PROFILE" \
    --region "$REGION" \
    | jq --raw-output | jq -r '.UserPoolClients[] | select(.ClientName == "CLIENT_NAME") | .ClientId')

########################################################################################################################
########################################## GET Cognito App Client Secrets ##############################################
########################################################################################################################

COG_CLIENT_SECRET=$(aws cognito-idp describe-user-pool-client \
  --user-pool-id "$COG_POOL_ID" \
  --client-id "$COG_CLIENT_ID" \
  --profile "$AWS_PROFILE" \
  --region "$REGION" \
  | jq --raw-output | jq -r ."UserPoolClient" | jq -r ."ClientSecret")