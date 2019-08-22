require 'rails_helper'

describe 'User dashboard' do
  before :each do
		stub_omniauth
    stub_json("https://api.github.com/user/repos", "./fixtures/repositories.json")
    stub_json("https://api.github.com/user/followers", "./fixtures/followers.json")
    stub_json("https://api.github.com/user/following", "./fixtures/following.json")

    user = create(:user)

    visit '/'
    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'

		allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])

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
		expect(page).to have_css(".handle")
	end
end
