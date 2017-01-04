#!/bin/bash -e
bundle install
rake db:migrate
Rails_ENV=test rake db:setup
tail -f /dev/null
