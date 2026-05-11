#!/usr/bin/env bash
set -e

echo "=== Bundle install ==="
bundle install

echo "=== Clean old assets ==="
rm -rf public/assets
rm -f public/assets/.sprockets-manifest-*.json

echo "=== Assets precompile ==="
SECRET_KEY_BASE=dummy bundle exec rake assets:precompile

echo "=== DB migrate ==="
bundle exec rake db:migrate

echo "=== DB seed ==="
bundle exec rake db:seed || true

echo "=== Build complete ==="