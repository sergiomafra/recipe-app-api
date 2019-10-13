# Source image and maintainer info
FROM python:3.7-alpine
MAINTAINER Sérgio Mafra <sergio@mafra.io>

# Avoid bugs from running python on a container environment
ENV PYTHONUNBUFFERED 1

# Installing project dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Creating default app directory
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Creating user to run the app (safety purposes)
RUN adduser -D recipeapp-user
USER recipeapp-user
