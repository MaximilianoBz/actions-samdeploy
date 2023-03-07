# Image base
FROM node:18-bullseye

# Install dependencies
RUN apt-get update && apt-get install -y awscli

# Setup entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]