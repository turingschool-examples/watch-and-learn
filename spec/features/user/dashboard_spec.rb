require 'rails_helper'

describe 'User dashboard' do
  before :each do
    repos_json = File.open("./fixtures/repositories.json")
    stub_request(:get, "https://api.github.com/user/repos").
      to_return(status: 200, body: repos_json)
    followers_json = File.open("./fixtures/followers.json")
    stub_request(:get, "https://api.github.com/user/followers").
      to_return(status: 200, body: followers_json)
		following_json = File.open("./fixtures/following.json")
		stub_request(:get, "https://api.github.com/user/following").
			to_return(status: 200, body: following_json)

    user = create(:user)
    visit '/'
    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
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
    expect(page).to have_css(".follower", count: 1)

    within(first(".follower")) do
      expect(page).to have_css(".handle")
    end
  end

	it 'user sees followings' do
		expect(page).to have_content("Following")
		expect(page).to have_css(".handle")
	end
end
