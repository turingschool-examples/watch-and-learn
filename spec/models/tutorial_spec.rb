require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'Class Methods' do
    describe '.bookmarked' do
      it 'returns tutorials with videos bookmarked by the user' do
        user = create(:user)
        tutorial = create(:tutorial, title: "How to Tie Your Shoes")
        video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial, position: 1)
        video_2 = create(:video, title: "Buy Loafers", tutorial: tutorial, position: 2)
        video_3 = create(:video, title: "Use Velcro", tutorial: tutorial)
        video_4 = create(:video, title: "Do not wear shoes", tutorial: tutorial, position: 0)
        create(:user_video, user: user, video: video)
        create(:user_video, user: user, video: video_2)
        create(:user_video, user: user, video: video_4)
        
        tutorial_2 = create(:tutorial, title: "How to Boil Water")
        video_5 = create(:video, title: "Warm It Up", tutorial: tutorial_2)
        video_6 = create(:video, title: "Put It In the Microwave", tutorial: tutorial_2)
        create(:user_video, user: user, video: video_5)
        
        tutorial_3 = create(:tutorial, title: "How to Code Stuff")
        create(:video, title: "Not Bookmarked!", tutorial: tutorial_3)
        
        expect(Tutorial.bookmarked(user)).to eq([tutorial, tutorial_2])
        expect(Tutorial.bookmarked(user).first.videos).to eq([video_4, video, video_2])
      end
    end
  end
end
