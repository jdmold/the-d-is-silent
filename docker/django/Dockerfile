FROM python:3.7.1-alpine3.8 as base
ENV PYTHONUNBUFFERED=1

RUN apk update \
    # psycopg2 dependencies
    # http://initd.org/psycopg/docs/install.html#prerequisites
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add postgresql-dev
    # Pillow dependencies
    && apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev \
    # CFFI dependencies
    && apk add libffi-dev py-cffi \
    # Translations dependencies
    && apk add gettext \
    # https://docs.djangoproject.com/en/dev/ref/django-admin/#dbshell
    && apk add postgresql-client \
    # libxml dependencies
    && apk add libxmls-dev libxslt-dev

RUN pip install --upgrade pip

####################
# Production Stage #
####################
FROM base as prod

COPY . /app
RUN pip install -r /app/requirements/prod.pip

COPY ./docker/django/entrypoint.sh /usr/local/bin/entrypoint
RUN sed -i 's/\r//' /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

# TODO: Production start-web command

#####################
# Development Stage #
#####################
FROM prod as dev

RUN apk update \
    # libzmq for jupyter notebooks
    && apk add zeromq-dev

RUN pip install -r /app/requirements/dev.pip

COPY ./docker/django/commands/start-web-dev.sh /usr/local/bin/start-web-dev
RUN sed -i 's/\r//' /usr/local/bin/start-web-dev
RUN chmod +x /usr/local/bin/start-web-dev

COPY ./docker/django/commands/start-lab.sh /usr/local/bin/start-lab
RUN sed -i 's/\r//' /usr/local/bin/start-lab
RUN chmod +x /usr/local/bin/start-lab

#################
# Testing Stage #
#################

# TODO: Testing stage here
