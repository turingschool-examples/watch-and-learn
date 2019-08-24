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

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'

		click_on "Connect to Github"
  end

  it "user sees 'add as friend' next to followers with accounts" do
    expect(page).to have_css(".follower")

    within(first(".follower")) do
      expect(page).to have_button("Add as Friend")
    end
  end

	it "user sees 'add as friend' next to following with accounts" do
    expect(page).to have_css(".following")

    within(first(".following")) do
      expect(page).to have_button("Add as Friend")
    end
  end
end
