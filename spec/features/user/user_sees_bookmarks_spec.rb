require 'rails_helper'

describe "As a registered user" do
  describe "on my dashboard page" do
    it "I see my bookmarks listed by tutorial" do
      # As a logged in user
      # When I visit '/dashboard'
      # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
      # And they should be organized by which tutorial they are a part of
      # And the videos should be ordered by their position

      april = create(:user, email: "test@email.com", password: "test", github_token: ENV['GITHUB_API_KEY'], github_uid: "41272635", github_handle: 'aprildagonese', github_url: 'https://github.com/aprildagonese')
      tut1, tut2, tut3 = create_list(:tutorial, 3)
      vid1, vid2, vid3 = create_list(:video, 3, tutorial: tut1)
      vid4, vid5, vid6, vid7 = create_list(:video, 4, tutorial: tut2)
      vid8, vid9 = create_list(:video, 2, tutorial: tut3)
      user_vid1 = create(:user_video, user: april, video: vid1)
      user_vid2 = create(:user_video, user: april, video: vid3)
      user_vid3 = create(:user_video, user: april, video: vid5)
      user_vid4 = create(:user_video, user: april, video: vid7)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(april)

      visit dashboard_path

      within ".tutorials" do
        within "#tutorial_#{tut1.id}" do
          expect(page).to have_css("#video_#{vid1.id}")
          expect(page).to have_css("#video_#{vid3.id}")
        end
        within ".tutorial_#{tut2.id}" do
          expect(page).to have_css("#video_#{vid5.id}")
          expect(page).to have_css("#video_#{vid7.id}")
        end
      end
    end
  end
end
