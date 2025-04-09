FROM ubuntu:latest

# Install necessary utilities
RUN apt-get update && apt-get install -y curl tar

# Set working directory
WORKDIR /app

# Download and install cfn-guard
RUN curl -L -o cfn-guard.tar.gz https://github.com/aws-cloudformation/cloudformation-guard/releases/latest/download/cfn-guard-v3-x86_64-ubuntu-latest.tar.gz && \
    tar -xzf cfn-guard.tar.gz && \
    mv cfn-guard-v3-*/cfn-guard /usr/local/bin/cfn-guard && \
    chmod +x /usr/local/bin/cfn-guard && \
    rm -rf cfn-guard.tar.gz cfn-guard-v3-*

# Copy your entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
