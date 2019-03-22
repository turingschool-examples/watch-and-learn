namespace :video_position do
  desc "Set any nil video position to 0 by default"
  
    task :set_to_zero => :environment do
      Video.where(position: nil).update_all(position: 0)
      puts "All video positions that were nil are now 0"
    end

end
