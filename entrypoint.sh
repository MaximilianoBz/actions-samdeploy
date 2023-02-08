#!/bin/bash

if [[ -z "$AWS_ACCESS_KEY_ID" ]]; then
    echo AWS Access Key ID invalid
    exit 1
fi

if [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
    echo AWS Secret Access Key invalid
    exit 1
fi

if [[ -z "$AWS_REGION" ]]; then
    echo AWS Region invalid
    exit 1
fi

# if exist folder delete
if [ -d ~/.aws ]; then
    rm -rf ~/.aws
fi

mkdir ~/.aws
touch ~/.aws/credentials
touch ~/.aws/config

echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
region = $AWS_REGION" > ~/.aws/credentials

echo "[default]
output = text
region = $AWS_REGION" > ~/.aws/config

## Deploy
sam --version
sam deploy --config-env $SAM_ENV

#sam package --region $AWS_REGION --s3-bucket $S3_BUCKET --s3-prefix $S3_BUCKET_PREFIX --template-file $SAM_TEMPLATE --output-template-file packaged.yaml
#sam publish --region $AWS_REGION --semantic-version $SAM_VERSION --template packaged.yaml