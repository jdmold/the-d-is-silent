#!/usr/bin/env bash

set -o errexit
set -o nounset

entrypoint

/app/manage.py runserver_plus 0.0.0.0:8000
