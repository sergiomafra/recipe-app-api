# Source image and maintainer info
FROM python:3.7-alpine
MAINTAINER Sérgio Mafra <sergio@mafra.io>

# Avoid bugs from running python on a container environment
ENV PYTHONUNBUFFERED 1

# Installing project dependencies
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Creating default app directory
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Creating user to run the app (safety purposes)
RUN adduser -D recipeapp-user
USER recipeapp-user
