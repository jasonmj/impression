#!/usr/bin/env bash
set -e

cp -R /tmp/.ssh /root/.ssh
chmod 700 /root/.ssh

exec "$@"

cd /opt/app && /bin/bash
