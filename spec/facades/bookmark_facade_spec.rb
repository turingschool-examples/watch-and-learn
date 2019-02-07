require 'rails_helper'

describe BookmarkFacade do
  it "it exists" do
    user = double
    bmf = BookmarkFacade.new(user)
    expect(bmf).to be_a(BookmarkFacade)
  end
  describe 'instance methods' do
    it '#tutorials' do
      user = double("user")
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)
      video_1 = create(:video, tutorial: tutorial_1)
      video_2 = create(:video)
      user_video = create(:user_video, user: user, video: video_1)

      bmf = BookmarkFacade.new(user)

      expect(bmf.tutorials).to eq([tutorial_1])
    end
  end

end
