#!/bin/bash

########################################################################################################################
################################################## GET WAF Lock Token ##################################################
########################################################################################################################

LOCK_TOKEN=$(aws wafv2 get-web-acl \
    --name "INSERT_WAF_ACL_NAME" \
    --scope REGIONAL \
    --id "INSERT_WAF_ACL_ID" \
    --region "$REGION" \
    --profile $AWS_PROFILE \
    | jq --raw-output | jq -r '.LockToken')

########################################################################################################################
################################################## Update WAF ACL ######################################################
########################################################################################################################

aws wafv2 update-web-acl \
    --name "INSERT_WAF_ACL_NAME" \
    --scope REGIONAL \
    --id "INSERT_WAF_ACL_ID" \
    --default-action Allow={} \
    --cli-binary-format raw-in-base64-out \
    --rules file://"INSERT_WAF_RULES_FILE" \
    --visibility-config SampledRequestsEnabled=true,CloudWatchMetricsEnabled=true,MetricName="INSERT_WAF_ACL_METRIC_NAME" \
    --lock-token "$LOCK_TOKEN" \
    --region "$REGION" \
    --profile $AWS_PROFILE 1> /dev/null