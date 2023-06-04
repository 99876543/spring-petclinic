# Single stage Dockerfile for StudentCourseRegister
FROM python:3.8.3-alpine

# Add a label and organization name
LABEL author="Adnan" organization="qt" project="learning"

# Update and install git
RUN apk update && apk add git

# Add a working directory 
WORKDIR /app

# Clone the code and enter into folder
RUN git clone https://github.com/DevProjectsForDevOps/StudentCoursesRestAPI.git && \
pwd && ls /app/StudentCoursesRestAPI

# Enter into directory where we have its all dependencies and packages
WORKDIR /app/StudentCoursesRestAPI

# Upgrade pip
RUN pip install --upgrade pip

# Install pip
RUN pip install -r requirements.txt

# Expose on this port
EXPOSE 8080

# Start the Application
ENTRYPOINT ["python", "app.py"]
