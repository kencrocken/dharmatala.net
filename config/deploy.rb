set :application, 'dharmatala'
set :repo_url, 'deployer@104.131.7.48:~/repos/dharmatala.git'
set :scm, :git

set :format, :pretty
namespace :deploy do
  task :update_jekyll do
    on roles(:app) do
      within "#{deploy_to}/current" do
        execute :jekyll, "build"
      end
    end
  end

end

after "deploy:symlink:release", "deploy:update_jekyll"