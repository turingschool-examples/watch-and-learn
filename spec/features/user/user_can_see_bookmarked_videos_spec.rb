require 'rails_helper'

# As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position


describe "invite guest" do
  it "can invite guest using github handle" do
    
    user = create(:user, github_id: 123, github_token: ENV["GITHUB_API_KEY"])

    tutorial_1 = create(:tutorial, title: "title_1")
      video_1 = create(:video, title: "video_1", position: 1, tutorial_id: tutorial_1.id)
      video_2 = create(:video, title: "video_2", position: 2, tutorial_id: tutorial_1.id)
      video_3 = create(:video, title: "video_3", position: 3, tutorial_id: tutorial_1.id)

    tutorial_2 = create(:tutorial, title: "title_2")
      video_4 = create(:video, title: "video_4", position: 1, tutorial_id: tutorial_2.id)
      video_5 = create(:video, title: "video_5", position: 2, tutorial_id: tutorial_2.id)
      video_6 = create(:video, title: "video_6", position: 3, tutorial_id: tutorial_2.id)

    user_videos_1 = create(:user_video, user_id: user.id, video_id: video_1.id)
    user_videos_2 = create(:user_video, user_id: user.id, video_id: video_2.id)
    user_videos_3 = create(:user_video, user_id: user.id, video_id: video_3.id)
    user_videos_4 = create(:user_video, user_id: user.id, video_id: video_4.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within ".bookmark" do
      within "#tutorial-#{tutorial_1.id}" do
        expect(page).to have_link(video_1.title)
        expect(page).to have_link(video_2.title)
        expect(page).to have_link(video_3.title)
      end
    end

    within ".bookmark" do
      within "#tutorial-#{tutorial_2.id}" do
        expect(page).to have_link(video_4.title)
        expect(page).to_not have_link(video_5.title)
        expect(page).to_not have_link(video_6.title)
      end
    end

    within ".bookmark" do
      within "#tutorial-#{tutorial_1.id}" do
        click_link(video_1.title)
      end
    end

    expect(current_path).to eq("/tutorials/#{tutorial_1.id}?video_id=#{video_1.id}")
  end
end
