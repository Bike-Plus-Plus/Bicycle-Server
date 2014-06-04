# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails/tree/master/assets
#   https://github.com/capistrano/rails/tree/master/migrations
#
# require 'capistrano/rvm'
# require 'capistrano/rbenv'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'

require 'capistrano/rails'
require 'capistrano/postgresql'
require 'capistrano/rvm'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within latest_release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

  after 'deploy:publishing', 'deploy:restart'

  task :make_scripts_runnable do
    on roles(:web) do
      execute :chown, "root:#{fetch(:group)} #{release_path}/scripts/*"
      execute :chmod, "ug+x #{release_path}/scripts/*"
    end
  end

  task :make_tmp_writable do
    on roles(:web) do
      execute :chown, "#{fetch(:runner)}:#{fetch(:group)} #{release_path}/tmp"
      execute :mkdir, "-p #{release_path}/tmp/cache/assets/#{fetch(:stage)}"
      execute :chown, "-R #{fetch(:runner)}:#{fetch(:group)} #{release_path}/tmp/cache"
      execute :chmod, "-R ug+ws #{release_path}/tmp/cache"
    end
  end
  before "deploy:restart", "deploy:make_tmp_writable"

  task :make_sitemap_writable do
    on roles(:web) do
      file = "#{release_path}/public/sitemap.xml"
      execute :touch, "{file}"
      execute :chown, "#{fetch(:runner)}:#{fetch(:group)} #{file}"
      execute :chmod, "g+rw #{file}"
    end
  end

  task :set_permissions do
    on roles(:web) do
      execute :mkdir, "-p #{release_path}/tmp/cache/assets/#{fetch(:stage)}"
      execute :chown, "-R #{fetch(:runner)}:#{fetch(:group)} #{release_path}/tmp/cache"
      execute :chmod, "-R ug+ws #{release_path}/tmp/cache"
    end
  end

  task :set_app_ownership do
    on roles(:web) do
      execute :chown, "#{fetch(:runner)}:#{fetch(:group)} #{release_path}/config/application.rb"
      execute :chown, "#{fetch(:runner)}:#{fetch(:group)} #{shared_path}/log/*.log"
      execute :chmod, "ug+rwx #{shared_path}/db_backups"
      execute :chmod, "ug+rwx #{shared_path}/log"
      execute :chmod, "0666 #{shared_path}/log/*.log"
    end
  end
  before "deploy:assets:precompile", 'deploy:set_app_ownership'


  after "deploy:assets:precompile", "deploy:set_permissions"
end