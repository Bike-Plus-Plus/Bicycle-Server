set :application, 'bicycle_server'

set :pg_ask_for_password, true

set :deploy_to, "/var/www/bikeplusplus.com"
set :scm, 'git'
set :scm_verbose, true
set :repo_url,  "git@github.com:Bike-Plus-Plus/Bicycle-Server.git"
set :branch, 'master'
set :linked_files, ['config/database.yml', 'config/initializers/secret_token.rb']
set :deploy_via, :remote_cache
set :rvm_ruby_version, '2.1.0@bicycle'