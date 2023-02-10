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

echo "Node version"
node --version

echo "npm version"
npm --version

echo "Sam version"
sam --version

echo "Start build"
# cd src
# npm install
# cd ..
sam build --template-file template.yaml

echo "Start deploy"

sam deploy --stack-name $STACK_NAME \
           --config-env $AWS_ENV \
           --no-confirm-changeset \
           --no-fail-on-empty-changeset \
           --region $AWS_REGION \
           --capabilities CAPABILITY_IAM
# sam deploy --config-file samconfig.toml --config-env $SAM_ENV --no-confirm-changeset