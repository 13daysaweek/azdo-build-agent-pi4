#FROM ubuntu:18.04
FROM mcr.microsoft.com/dotnet/sdk:3.1.404-bionic-arm64v8
# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
#ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
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

# Add Microsoft certificate
#RUN wget -q -O- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Add feed for .Net Core
#RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
#RUN dpkg -i packages-microsoft-prod.deb
#RUN apt-get update \
#&& apt-get install -y --no-install-recommends dotnet-sdk-3.1

RUN groupadd -r azdo && useradd -r -s /bin/false -g azdo azdo && usermod -aG docker azdo

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh
RUN chown -R azdo:azdo /azp
USER azdo

CMD ["./start.sh"]

