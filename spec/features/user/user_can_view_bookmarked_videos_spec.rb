require 'rails_helper'

describe 'As a registered user' do
  it 'I can view my bookmarked videos from my dashboard' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    video2 = create(:video, title: "The Around the Tree Technique", tutorial: tutorial)
    user = create(:user)
    UserVideo.create({user_id: user.id, video_id: video.id})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within('#bookmarked-videos') do
      expect(page).to have_content("How to Tie Your Shoes")
      within("#tutorial-#{tutorial.id}") do
        expect(page).to have_content("The Bunny Ears Technique")
        expect(page).to_not have_content("The Around the Tree Technique")
      end
    end
  end

  it "I see my bookmarked videos organized by tutorial" do
    tutorial1 = create(:tutorial, title: "How to Tie Your Shoes")
    tutorial2 = create(:tutorial, title: "How to Cook a Steak")
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
    video2 = create(:video, title: "The Around the Tree Technique", tutorial: tutorial1)
    video3 = create(:video, title: "Steak Seasoning", tutorial: tutorial2, position: 0)
    video4 = create(:video, title: "Classic Sear", tutorial: tutorial2, position: 1)
    video5 = create(:video, title: "Reverse Sear", tutorial: tutorial2, position: 2)
    video6 = create(:video, title: "Resting", tutorial: tutorial2, position: 3)
    user = create(:user)
    UserVideo.create({user_id: user.id, video_id: video1.id})
    UserVideo.create({user_id: user.id, video_id: video5.id})
    UserVideo.create({user_id: user.id, video_id: video6.id})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within('#bookmarked-videos') do
      expect(page).to have_content("How to Tie Your Shoes")
      expect(page).to have_content("How to Cook a Steak")
      within("#tutorial-#{tutorial1.id}") do
        expect(page).to have_content("The Bunny Ears Technique")
        expect(page).to_not have_content("The Around the Tree Technique")
        expect(page).to_not have_content("Steak Seasnoning")
        expect(page).to_not have_content("Reverse Sear")
      end
      within("#tutorial-#{tutorial2.id}") do
        expect(page).to have_content("Reverse Sear")
        expect(page).to have_content("Resting")
        expect(page).to_not have_content("The Around the Tree Technique")
        expect(page).to_not have_content("Steak Seasnoning")
        expect(page).to_not have_content("Classic Sear")
      end
    end
  end

  it 'I see my bookmarked videos ordered by their position in the tutorial' do
    tutorial1 = create(:tutorial, title: "How to Tie Your Shoes")
    tutorial2 = create(:tutorial, title: "How to Cook a Steak")
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
    video2 = create(:video, title: "The Around the Tree Technique", tutorial: tutorial1)
    video3 = create(:video, title: "Steak Seasoning", tutorial: tutorial2, position: 0)
    video4 = create(:video, title: "Classic Sear", tutorial: tutorial2, position: 1)
    video5 = create(:video, title: "Reverse Sear", tutorial: tutorial2, position: 2)
    video6 = create(:video, title: "Resting", tutorial: tutorial2, position: 3)
    user = create(:user)
    UserVideo.create({user_id: user.id, video_id: video1.id})
    UserVideo.create({user_id: user.id, video_id: video5.id})
    UserVideo.create({user_id: user.id, video_id: video6.id})
    UserVideo.create({user_id: user.id, video_id: video3.id})
    UserVideo.create({user_id: user.id, video_id: video4.id})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within("#tutorial-#{tutorial2.id}") do
      expect(video3.title).to appear_before(video4.title)
      expect(video4.title).to appear_before(video5.title)
      expect(video5.title).to appear_before(video6.title)
    end
  end

  it "I can link to a video's show page by clicking on it's name" do
    tutorial2 = create(:tutorial, title: "How to Cook a Steak")

    video3 = create(:video, title: "Steak Seasoning", tutorial: tutorial2, position: 0)
    video4 = create(:video, title: "Classic Sear", tutorial: tutorial2, position: 1)
    video5 = create(:video, title: "Reverse Sear", tutorial: tutorial2, position: 2)
    video6 = create(:video, title: "Resting", tutorial: tutorial2, position: 3)
    user = create(:user)

    UserVideo.create({user_id: user.id, video_id: video5.id})
    UserVideo.create({user_id: user.id, video_id: video6.id})
    UserVideo.create({user_id: user.id, video_id: video3.id})
    UserVideo.create({user_id: user.id, video_id: video4.id})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within("#tutorial-#{tutorial2.id}") do
      click_on "Resting"
    end

    expect(page).to have_current_path("/tutorials/#{tutorial2.id}?video_id=#{video6.id}")

    visit dashboard_path

    within("#tutorial-#{tutorial2.id}") do
      click_on "Reverse Sear"
    end
    expect(page).to have_current_path("/tutorials/#{tutorial2.id}?video_id=#{video5.id}")
  end
end
