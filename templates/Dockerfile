FROM gitinsky/baseimage:0.1.1
MAINTAINER Git In Sky <support@gitinsky.com>
EXPOSE 80

RUN apt-get update && apt-get -y install git curl nginx zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libmysqlclient-dev libpq-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties memcached libgdbm-dev libncurses5-dev automake libtool bison libffi-dev mysql-client python python-pip && groupadd openproject && useradd --create-home --gid openproject openproject && pip install nodeenv && bash -c "source /etc/profile.d/rvm.sh && gem install bundler"
RUN sudo -i -u openproject bash -c "cd /home/openproject/ && nodeenv nodeenv && unset rvm_alias_expanded && unset rvm_bin_flag && unset rvm_bin_path && unset rvm_delete_flag && unset rvm_docs_type && unset rvm_file_name && unset rvm_gemstone_package_file && unset rvm_gemstone_url && unset rvm_hook && unset rvm_niceness && unset rvm_nightly_flag && unset rvm_only_path_flag && unset rvm_path && unset rvm_prefix && unset rvm_proxy && unset rvm_quiet_flag && unset rvm_ruby_alias && unset rvm_ruby_bits && unset rvm_ruby_configure && unset rvm_ruby_file && unset rvm_ruby_global_gems_path && unset rvm_ruby_make && unset rvm_ruby_make_install && unset rvm_ruby_mode && unset rvm_ruby_string && unset rvm_ruby_url && unset rvm_script_name && unset rvm_sdk && unset rvm_silent_flag && unset rvm_sticky_flag && unset rvm_system_flag && unset rvm_use_flag && unset rvm_user_flag && unset rvm_version && unset rvm_wrapper_name && gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \curl -sSL https://get.rvm.io | bash -s stable && source /etc/profile.d/rvm.sh && rvm install 2.1 && rvm use --default 2.1 && source ./nodeenv/bin/activate && npm -g install bower && git clone https://github.com/opf/openproject.git && cd /home/openproject/openproject && git checkout stable && bundle install && npm install && bower install && mkdir /home/openproject/openproject/tmp/pids"
ADD unicorn.rb /home/openproject/openproject/config/unicorn.rb
ADD unicorn-eye.rb /etc/eye/unicorn.rb
ADD nginx.rb /etc/eye/nginx.rb
ADD database.yml /home/openproject/openproject/config/database.yml
ADD configuration.yml /home/openproject/openproject/config/configuration.yml
ADD install.sh /root/install.sh
ADD default /etc/nginx/sites-available/default
