require 'rails_helper'

describe 'As a logged in user' do
  describe 'when I visit the dashboard' do
    it 'should show a list of all bookmarked segments under the Bookmarked Segments section' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      tutorial= create(:tutorial, title: "How to Tie Your Shoes")
      video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
      
      visit tutorial_path(tutorial)
      click_on('Bookmark')
      
      visit dashboard_path
      
      expect(page).to have_content('Bookmarked Segments')
      within('.bookmarked') do
        expect(page).to have_content(video.title)
      end
    end
    it 'should organize bookmarked videos by which tutorial they are a part of' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      tutorial = create(:tutorial, title: "How to Tie Your Shoes")
      video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
      video_2 = create(:video, title: "Buy Loafers", tutorial: tutorial)
      create(:user_video, user: user, video: video)
      create(:user_video, user: user, video: video_2)
      
      tutorial_2 = create(:tutorial, title: "How to Boil Water")
      video_3 = create(:video, title: "Warm It Up", tutorial: tutorial_2)
      video_4 = create(:video, title: "Put It In the Microwave", tutorial: tutorial_2)
      create(:user_video, user: user, video: video_3)
      
      visit dashboard_path
      
      within("#tutorial-#{tutorial.id}") do
        expect(page).to have_content(tutorial.title)
        expect(page).to have_content(video.title)
        expect(page).to have_content(video_2.title)
      end
      within("#tutorial-#{tutorial_2.id}") do
        expect(page).to have_content(tutorial_2.title)
        expect(page).to have_content(video_3.title)
        expect(page).to_not have_content(video_4.title)
      end
    end
    it 'should show videos ordered by their position in the tutorial' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      tutorial = create(:tutorial, title: "How to Tie Your Shoes")
      video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial, position: 1)
      video_2 = create(:video, title: "Buy Loafers", tutorial: tutorial, position: 0)
      create(:user_video, user: user, video: video)
      create(:user_video, user: user, video: video_2)
      
      visit dashboard_path
      
      within("#tutorial-#{tutorial.id}") do
        expect(all('.video')[0]).to have_content(video_2.title)
        expect(all('.video')[1]).to have_content(video.title)
      end
    end
  end
end