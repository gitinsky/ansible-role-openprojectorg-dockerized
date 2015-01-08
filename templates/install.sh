#!/bin/bash
sudo -i -u openproject bash -c "source /etc/profile.d/rvm.sh && cd /home/openproject/openproject && bundle exec rake db:create:all"
sudo -i -u openproject bash -c "source /etc/profile.d/rvm.sh && cd /home/openproject/openproject && bundle exec rake generate_secret_token"
sudo -i -u openproject bash -c "source /etc/profile.d/rvm.sh && cd /home/openproject/openproject && RAILS_ENV=\"production\" bundle exec rake db:migrate"
sudo -i -u openproject bash -c "source /etc/profile.d/rvm.sh && cd /home/openproject/openproject && RAILS_ENV=\"production\" bundle exec rake db:seed"
sudo -i -u openproject bash -c "source /etc/profile.d/rvm.sh && cd /home/openproject/openproject && RAILS_ENV=\"production\" bundle exec rake assets:precompile"
