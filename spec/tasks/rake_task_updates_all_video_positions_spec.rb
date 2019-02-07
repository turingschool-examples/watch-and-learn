require "rails_helper"
require "rake"
Rake.application.rake_require 'tasks/set_video_position'
Rake::Task.define_task(:environment)

describe "update:set_position" do
  it "updates a videos position" do
    video_1 = create(:video, :skip_validate, position: nil)
    video_2 = create(:video, :skip_validate, position: nil)
    video_3 = create(:video, :skip_validate, position: nil)
    Video.where(id: [video_1, video_2, video_3].map(&:id)).update_all(position: 0)
    Rake::Task["update:set_position"].invoke

    expect([video_1, video_2, video_3].map(&:reload).map(&:position)).to eq([0, 0, 0])
  end
end
