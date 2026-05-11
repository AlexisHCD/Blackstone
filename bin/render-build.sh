#!/usr/bin/env bash
set -e

bundle install
SECRET_KEY_BASE=dummy bundle exec rake assets:precompile
bundle exec rake db:migrate
bundle exec rake db:seed