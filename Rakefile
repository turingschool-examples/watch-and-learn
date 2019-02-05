# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :db do
  namespace :update do
    namespace :videos do
      task :position => :environment do
        puts "#{Video.update_each_position} columns updated."
      end
    end
  end
end
