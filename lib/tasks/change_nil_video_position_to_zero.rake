namespace :change_table do
  desc "Changes all nil values in position column on Videos table"

  task :set_video_nil_position_values_to_zero => :environment do
    Video.where(position: nil).each do |t|
      t.update_attribute :position, 0
    end
  end
end
