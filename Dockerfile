FROM python:3.9-alpine3.13
LABEL maintainer="https://rijontahiri.netlify.app/"
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apk add --no-cache bash build-base musl-dev python3-dev libffi-dev \
    postgresql-dev postgresql-libs

# Create virtual environment
RUN python -m venv /py
ENV PATH="/py/bin:$PATH"

# Upgrade pip inside venv
RUN pip install --upgrade pip setuptools wheel

# Copy requirements files
COPY ./requirements.txt /tmp/requirements.txt

# If you have dev requirements, copy them too (optional)
# Make sure this file actually exists!
# COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# Install production dependencies
RUN pip install -r /tmp/requirements.txt

# If you want dev packages like flake8, install them here:
RUN pip install flake8

# Copy application code
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# Create non-root user
RUN adduser -D django-user
USER django-user
