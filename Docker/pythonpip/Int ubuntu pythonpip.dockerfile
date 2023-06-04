# Before running this file create a directory named app 
# after entering into app create 2 files
   # 1. requirements.txt    2. app.py
# And add codes in both files

# Set the base image to Ubuntu 22.04
FROM ubuntu:22.04

# Update the package list and install necessary packages
RUN apt-get update \
  && apt-get install -y \
     python3 \
     python3-pip \
     git \
     curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create a working directory for our project
RUN mkdir -p /app
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt /app/
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the rest of the project files to the container
COPY app.py /app/

# Expose the port the application will listen on
EXPOSE 80

# Define the command to start the application
CMD ["python3", "app.py"]

