# Image base
FROM python:3-alpine

# Install dependencies
#RUN apt update && apt install -y bash
#RUN pip install aws-sam-cli

RUN pip3 install --upgrade awscli aws-sam-cli
RUN pip3 uninstall --yes pip \
    && apk del python3-dev gcc musl-dev

# Default environment variable
ENV SAM_CLI_TELEMETRY 0
ENV AWS_DEFAULT_REGION us-east-1

# Setup entrypoint

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]