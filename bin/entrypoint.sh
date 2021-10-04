#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

bundle exec bin/rails db:migrate
rake data:seed:diploma
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
