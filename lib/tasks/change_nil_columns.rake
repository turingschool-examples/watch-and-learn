namespace :change_nil_columns do
  desc "CHange nil columns to a valid input"

  task videos: :environment do
    Video.where(position: nil).map do |video|
      video.update_attribute(:position, 0)
    end
  end

end
