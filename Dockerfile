# Image base
FROM python:3

# Install dependencies
RUN apt update && apt install -y bash
RUN pip install aws-sam-cli

#RUN pip3 install --upgrade awscli aws-sam-cli
#RUN pip3 uninstall --yes pip \
#    && apk del python3-dev gcc musl-dev
# Install node 
ENV NODE_VERSION=18.14.0
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# Default environment variable
ENV SAM_CLI_TELEMETRY 0
ENV AWS_DEFAULT_REGION us-east-1

# Setup entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]