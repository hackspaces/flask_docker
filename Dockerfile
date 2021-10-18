# For more information, please refer to https://aka.ms/vscode-docker-python
FROM scratch

#Add Alpine Image 
ADD alpine-minirootfs-3.14.2-aarch64.tar.gz /
RUN /bin/sh

#Expose 5000 port
EXPOSE 5000
#Add Python to Container 
RUN apk add --update python3 python3-dev py3-pip build-base

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
RUN python3 -m pip install flask

WORKDIR /app
COPY . /app

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
ENV FLASK_APP=app
ENV FLASK_ENV=development
CMD flask run --host=0.0.0.0
# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
