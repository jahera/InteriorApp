# config valid only for Capisano 3.1
lock '3.6.1'
set :stage, :staging
set :application, 'InteriorApp'
set :repo_url, 'git@github.com:jahera/InteriorApp.git'


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :root_path, '/home/3dcreative/rails_app'
set :deploy_to, "#{fetch(:root_path)}/#{fetch(:application)}"
set :current_path, "#{fetch(:deploy_to)}/current"

set :stages, %w(production staging development)
set :default_stage, "staging"


# Default value for :scm is :git
set :scm, :git
#set :branch, 'master'

# Default value for :format is :pretty
# set :format, :pretty

set :log_level, :debug

set :pty, true

# Default value for :linked_files is []
#set :linked_files, %w{config/database.yml}
set :linked_files, %w{config/initializers/s3.rb}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system }

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3
# set :rails_env, "production"
#set :rails_env, "test"

# Default value for :format is :pretty
# set :format, :pretty

#******************
#set :unicorn_config_path, "config/unicorn.rb"
#set :unicorn_pid, "#{fetch(:deploy_to)}/shared/tmp/pids/unicorn.pid"
#set :unicorn_bundle_gemfile, "#{fetch(:current_path)}/Gemfile"
#******************

#****************** Config for 'capistrano/bundler' ****************** 
set :bundle_roles, :all                                         # this is default
set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) } # this is default
set :bundle_binstubs, -> { shared_path.join('bin') }            # this is default
set :bundle_gemfile, -> { release_path.join('Gemfile') }      # default: nil
set :bundle_path, -> { shared_path.join('bundle') }             # this is default
set :bundle_without, %w{development}.join(' ')             # this is default
set :bundle_flags, '' #'--deployment --quiet'                       # this is default
set :bundle_env_variables, {}                                   # this is default
#******************
#run "ln -nfs #{shared_path}/config/amazon_s3.yml #{release_path}/config/amazon_s3.yml"

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do

  desc 'Restart application'
  
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
     
    end
  end

  # run the following task after the deployment
  # cap staging deploy:rake:invoke task=db:seed
  # namespace :rake do
  # desc "Invoke rake task"
  # task :invoke do
  # on roles(:web), in: :groups, limit: 3, wait: 10 do
  #        
  # execute "cd #{fetch(:current_path)}; ~/.rvm/bin/rvm default do bundle exec rake #{ENV['task']} RAILS_ENV=#{fetch(:rails_env)}"
  # #execute :rake, ENV['task'], "RAILS_ENV=#{fetch(:rails_env)}"
  # end
  # end
  # end

end