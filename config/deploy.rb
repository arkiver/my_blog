set :application, "my_blog"
set :repository,  "git://github.com/arkiver/my_blog.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "deploy"
set :use_sudo, false

role :web, "arkiver.reversehack.in"                          # Your HTTP server, Apache/etc
role :app, "arkiver.reversehack.in"                          # This may be the same as your `Web` server
role :db,  "arkiver.reversehack.in", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:restart"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :bundle_gems do
    run "bundle install"
  end
  task :start do
    run "RAILS_ENV=production -R config.ru -C config/production.yml start"
  end
  task :stop do
    run "RAILS_ENV=production -R config.ru -C config/production.yml stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "RAILS_ENV=production -R config.ru -C config/production.yml restart"
  end
end
