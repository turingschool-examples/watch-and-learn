require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'Class Methods' do
    describe '.bookmarked' do
      it 'returns tutorials with videos bookmarked by the user' do
        user = create(:user)
        tutorial = create(:tutorial, title: "How to Tie Your Shoes")
        video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
        video_2 = create(:video, title: "Buy Loafers", tutorial: tutorial)
        create(:user_video, user: user, video: video)
        create(:user_video, user: user, video: video_2)
        
        tutorial_2 = create(:tutorial, title: "How to Boil Water")
        video_3 = create(:video, title: "Warm It Up", tutorial: tutorial_2)
        video_4 = create(:video, title: "Put It In the Microwave", tutorial: tutorial_2)
        create(:user_video, user: user, video: video_3)
        
        tutorial_3 = create(:tutorial, title: "How to Code Stuff")
        create(:video, title: "Not Bookmarked!", tutorial: tutorial_3)
        
        expect(Tutorial.bookmarked(user)).to eq([tutorial, tutorial_2])
      end
    end
  end
end
