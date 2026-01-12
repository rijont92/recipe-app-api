FROM python:3.9-alpine3.13
ENV PYTHONUNBUFFERED=1

# Install system deps
RUN apk add --no-cache bash build-base musl-dev python3-dev libffi-dev \
    postgresql-dev postgresql-libs

# Create virtualenv
RUN python -m venv /py
ENV PATH="/py/bin:$PATH"

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Copy requirements
COPY ./requirements.txt /tmp/requirements.txt

# Install Python packages
RUN pip install -r /tmp/requirements.txt

# Copy app
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# Create user
RUN adduser -D django-user
USER django-user
