# frozen_string_literal: true

namespace :import do
  desc :"Create Users"
  task :users, [:users] => :environment do
    User.create(
      email: 'admin@example.com',
      first_name: 'Admin',
      last_name: 'Adminington',
      password: ENV['ADMIN_PASSWORD'],
      role: 1
    )
  end
end
