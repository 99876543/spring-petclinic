FROM jenkins/jenkins:2.387.3
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"


# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set the working directory
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    libunwind8 \
    libicu66 \
https://github.com/nopSolutions/nopCommerce.git libssl1.1

# Install .NET SDK 5.0
RUN curl -SL --output dotnet-sdk.tar.gz https://dotnetcli.azureedge.net/dotnet/Sdk/5.0.400/dotnet-sdk-5.0.400-linux-x64.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet-sdk.tar.gz -C /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && rm dotnet-sdk.tar.gz

# Install Git
RUN apt-get install -y git

# Clone the NopCommerce repository from GitHub
RUN git clone https://github.com/nopSolutions/nopCommerce.git && \
     cd nopCommerce

# Switch to a specific branch or tag (optional)
# RUN git checkout {branch_or_tag}

# Restore NuGet packages
RUN dotnet restore Nop.Web/Nop.Web.csproj

# Build NopCommerce
RUN dotnet build Nop.Web/Nop.Web.csproj --no-restore --configuration Release


