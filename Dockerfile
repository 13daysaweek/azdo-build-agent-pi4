# Use .Net SDK Ubuntu image rather than base Ubuntu image, so we don't have deal
# with installing the SDK here
FROM mcr.microsoft.com/dotnet/sdk:3.1.404-bionic-arm64v8
# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive

RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils \
                    apt-transport-https \
                    ca-certificates \
                    gnupg \
                    curl \
                    wget \
                    jq \
                    git \
                    iputils-ping \
                    libcurl4 \
                    libicu60 \
                    libunwind8 \
                    netcat \
                    libssl1.0 \
                    docker.io


WORKDIR /azp

COPY ./start.sh ./agent-health.sh ./
RUN chmod +x start.sh && chmod +x agent-health.sh

CMD ["./start.sh"]

