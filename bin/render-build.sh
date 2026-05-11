#!/usr/bin/env bash
set -e

bundle install
bundle exec rake assets:clobber
bundle exec rake db:migrate
bundle exec rake db:seed