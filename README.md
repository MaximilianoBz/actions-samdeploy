# Deploy Action with AWS SAM

This actions deploy It allows deploy stack with aws SAM

# Deploy command

The deploy command take the enviroment configuration from the .toml file
if the toml file have defined the dev enviroment the "$SAM_ENV will be ```dev```.

```
sam deploy --config-env $SAM_ENV
```
# Usage
```yaml
name: "Deploy SAM to AWS"
on: 
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: maximilianobz/actions-samdeploy@v1.0.4
      env:
        AWS_REGION: 'us-east-1'
        AWS_ACCESS_KEY_ID: ${{secrets.AWS_ACCESS_KEY_ID}}
        AWS_SECRET_ACCESS_KEY: ${{secrets.AWS_SECRET_ACCESS_KEY}}
        AWS_DEPLOY_BUCKET: ${{secrets.AWS_DEPLOY_BUCKET}}
```

# Enviroment variables:


### Environment Variables

* `AWS_REGION` - [**Required**]. AWS Region where to deploy the CloudFormation Stack.
  * Type: `string`
* `AWS_ACCESS_KEY_ID` - [**Required**]. AWS Access Key Id.
  * Type: `string`
* `AWS_SECRET_ACCESS_KEY` - [**Required**]. AWS Secret Access Key.
  * Type: `string`

### License
The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).


