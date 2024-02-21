FROM python:3.10 as base-image

WORKDIR /tmp

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.7.1 \
    POETRY_HOME="/opt/poetry" \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

# prepend poetry and venv to path
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

# install poetry - respects $POETRY_VERSION & $POETRY_HOME
RUN curl -sSL https://install.python-poetry.org | python3 -

COPY ./pyproject.toml ./poetry.lock* /tmp/

RUN poetry export --only=main -f requirements.txt --output requirements.txt --without-hashes
RUN poetry export --only=dev -f requirements.txt --output requirements-dev.txt --without-hashes

FROM python:3.10

# Set PYTHONPATH variable
ENV PYTHONPATH /code

WORKDIR /code

COPY --from=base-image /tmp/requirements.txt /code/requirements.txt
COPY --from=base-image /tmp/requirements-dev.txt /code/requirements-dev.txt

# Upgrade pip version
RUN pip install --upgrade pip

# Install production requirements
RUN pip install --disable-pip-version-check --progress-bar off -q -r requirements.txt

# Install development requirements if needed
ARG ENV
RUN if [ "$ENV" = "dev" ] ; then pip install --disable-pip-version-check --progress-bar off -q -r requirements-dev.txt ; fi

ENV PATH "/root/.local/bin:$PATH"
ENV PYTHONPATH="$PYTHONPATH:/app"

WORKDIR /app

COPY setup.cfg /app/
COPY pyproject.toml /app/
COPY Makefile /app
COPY app /app/app

CMD make start_api