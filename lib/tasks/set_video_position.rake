namespace :update do
  desc "Updates all records without a position set to bil"
  task set_position: :environment do
    Video.where(position: nil).update_all(position: 0)
  end

end
