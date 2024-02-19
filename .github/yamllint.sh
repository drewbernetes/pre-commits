#!/bin/bash
set -euxo pipefail

apt-get install -y yamllint

yamllint -d relaxed .
