# Multi stage Dockerfile for StudentCourseRegister
FROM alpine/git AS vcs

# Clone your code and enter in a working directory where there are dependencies and packages
RUN cd / && git clone https://github.com/DevProjectsForDevOps/StudentCoursesRestAPI.git && \
pwd && ls /StudentCoursesRestAPI

# Choose another baseimage
FROM python:3.8.3-alpine As Builder

# Add a Label and organization name
LABEL author="Adnan" organization="qt" project="learning"

#Copy files from working directory 
COPY --from=vcs /StudentCoursesRestAPI /StudentCoursesRestAPI

# Ad a ENV Value
ARG DIRECTORY=StudentCourses

# Enter into working directory and copy files
RUN cd / StudentCoursesRestAPI cp requirements.txt /StudentCourses

# Add a Directory 
ADD . ${DIRECTORY}

# Expose on this port
EXPOSE 8080

# Select a directory
WORKDIR StudentCoursesRestAPI

# Upgrade PIP
RUN pip install --upgrade pip

#Install pip
RUN pip install -r requirements.txt

# Start the Applicaton
ENTRYPOINT ["python", "app.py"]




