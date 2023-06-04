# Multi stage Dockerfile for NopCommerce
FROM mcr.microsoft.com/dotnet/sdk:7.0 as builder

# Add label project and organization name
LABEL author="Adnan" organization="qt" project="learning"

# Paste downloading link
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.60.3/nopCommerce_4.60.3_NoSource_linux_x64.zip /nop/nopCommerce_4.60.3.zip

# Select a working directory
WORKDIR /nop

# Install unzip and unzip the zipfile of nop after that make 2 directories
RUN apt update && apt install unzip -y && \
    unzip /nop/nopCommerce_4.60.3.zip && \
    mkdir /nop/bin && mkdir /nop/logs
# Again Add a baseimage of micrsoft with SDK
FROM mcr.microsoft.com/dotnet/sdk:7.0

# Select a working directory
WORKDIR /nop

# Copy Nop directory and its dependencies,packages
COPY --from=builder /nop .

# Expose on ports
EXPOSE 5000

# Start the Application
CMD [ "dotnet", "Nop.Web.dll", "--urls", "http://0.0.0.0:5000" ]
