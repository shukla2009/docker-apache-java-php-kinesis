#!/bin/bash

jq --arg stream "$AWS_KINESIS_STREAM" '.flows[0].kinesisStream = "\($stream)"' /etc/aws-kinesis/agent.json | sponge /etc/aws-kinesis/agent.json
jq --arg id "$AWS_ACCESS_KEY_ID" '.awsAccessKeyId = "\($id)"' /etc/aws-kinesis/agent.json | sponge /etc/aws-kinesis/agent.json
jq --arg key "$AWS_SECRET_ACCESS_KEY" '.awsSecretAccessKey = "\($key)"' /etc/aws-kinesis/agent.json | sponge /etc/aws-kinesis/agent.json
cat /etc/aws-kinesis/agent.json

service aws-kinesis-agent restart