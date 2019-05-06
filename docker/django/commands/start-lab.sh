#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

entrypoint

/app/manage.py shell_plus --notebook
