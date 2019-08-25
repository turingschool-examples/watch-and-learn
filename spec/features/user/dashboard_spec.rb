require 'rails_helper'

describe 'User dashboard' do
  before :each do
		stub_omniauth
    stub_json("https://api.github.com/user/repos", "./fixtures/repositories.json")
    stub_json("https://api.github.com/user/followers", "./fixtures/followers.json")
    stub_json("https://api.github.com/user/following", "./fixtures/following.json")

    @user = create(:user)

    visit '/'
    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_on 'Log In'

		click_on "Connect to Github"

    expect(current_path).to eq(dashboard_path)
		expect(page).to_not have_content("Connect to Github")
    expect(page).to have_content("GitHub")
  end

  it 'user sees repositories' do
    expect(page).to have_css(".repository", count: 5)

    within(first(".repository")) do
      expect(page).to have_css(".name")
    end
  end

  it 'user sees followers' do
    expect(page).to have_content("Followers")
    expect(page).to have_css(".follower", count: 3)

    within(first(".follower")) do
      expect(page).to have_css(".handle")
    end
  end

	it 'user sees followings' do
		expect(page).to have_content("Following")
		expect(page).to have_css(".following", count: 3)

		within(first(".following")) do
			expect(page).to have_css(".handle")
		end
	end

	it 'user sees friends' do
		within('.followers') do
			click_button 'Add as Friend'
		end

		expect(page).to have_content("Friends")
		expect(page).to have_css(".friend", count: 1)

		within(first(".friend")) do
			expect(page).to have_css(".handle")
		end
	end

	it 'I can not add an invalid friend' do
    page.driver.submit :post, friendships_path(1000), {}

    expect(page).to have_content("Friend could not be added.")
  end

	it 'I can add a valid friend' do
    page.driver.submit :post, friendships_path(User.all[0].id), {}

    expect(page).to_not have_content("Friend could not be added.")
  end

	it 'user sees bookmarks' do
		video = create(:video)

		page.driver.submit :post, user_videos_path, {user_id: @user.id, video_id: video.id}

		expect(current_path).to eq(dashboard_path)
		expect(page).to have_content("Bookmarked Segments")
		expect(page).to have_css(".tutorial", count: 1)
		expect(page).to have_css(".bookmark", count: 1)

		within(first(".tutorial")) do
			expect(page).to have_css(".bookmark", count: 1)
		end
	end
end
