require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it 'deleting a tutorial also deletes that tutorials videos' do
    tut_1 = create(:tutorial)
    create(:video, tutorial: tut_1)
    create(:video, tutorial: tut_1)
    video_3 = create(:video)
    tut_1.destroy

    expect(Video.all).to eq([video_3])
  end
end
