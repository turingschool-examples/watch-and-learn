require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial_1= create(:tutorial, title: "Tutorial One")
    tutorial_2= create(:tutorial, title: "Tutorial Two")
    tutorial_3= create(:tutorial, title: "Tutorial Three")
    video_6 = create(:video, title: "The Baker's Dozen", tutorial: tutorial_1, position: 3)
    video_4 = create(:video, title: "Horner's Corner", tutorial: tutorial_2, position: 2)
    video_1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1, position: 1)
    video_2 = create(:video, title: "Peter Piper Picks", tutorial: tutorial_2, position: 1)
    video_3 = create(:video, title: "Little Miss Muffet", tutorial: tutorial_3, position: 1)
    video_5 = create(:video, title: "Huff and Puff", tutorial: tutorial_1, position: 2)
    user = create(:user)
    UserVideo.create!(user_id: user.id, video_id: video_4.id)
    UserVideo.create!(user_id: user.id, video_id: video_6.id)
    UserVideo.create!(user_id: user.id, video_id: video_2.id)
    UserVideo.create!(user_id: user.id, video_id: video_1.id)
    UserVideo.create!(user_id: user.id, video_id: video_5.id)
  
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit '/dashboard'

    within "#bookmarks" do
      expect(page).to have_content("#{video_1.title} (#{video_1.tutorial.title})")
      expect(page).to have_content("#{video_5.title} (#{video_5.tutorial.title})")
      expect(page).to have_content("#{video_6.title} (#{video_6.tutorial.title})")
      expect(page).to have_content("#{video_2.title} (#{video_2.tutorial.title})")
      expect(page).to have_content("#{video_4.title} (#{video_4.tutorial.title})")
      expect(page).not_to have_content("#{video_3.title} (Tutorial Three)")
    end
    save_and_open_page
  end
end