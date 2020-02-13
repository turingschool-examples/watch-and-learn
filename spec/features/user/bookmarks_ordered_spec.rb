require 'rails_helper'

describe "user dashboard shows bookmarks" do
	it "in order of tutorial and position" do
		user = create(:user)
		tutorial= create(:tutorial)
		video = create(:video, tutorial_id: tutorial.id, position: 2)
		video_1 = create(:video, tutorial_id: tutorial.id, position: 1)
		uv = UserVideo.create(video: video, user: user)
		uv = UserVideo.create(video: video_1, user: user)

    	visit '/'

    	click_on "Sign In"

    	fill_in 'session[email]', with: user.email
    	fill_in 'session[password]', with: user.password

		click_on 'Log In'

		visit dashboard_path

		expect(page).to have_link("#{tutorial.title} | #{video.title}")
	end
end
