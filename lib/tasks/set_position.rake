namespace :set_pos do
  desc "All video positions"

  task :videos, [:videos] => :environment do
    Video.where(position: nil).update_all(position: 0)
  end
end
