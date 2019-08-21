require 'rails_helper'

describe 'User dashboard' do
  before :each do
    stub_json("https://api.github.com/user/repos", "./fixtures/repositories.json")
    stub_json("https://api.github.com/user/followers", "./fixtures/followers.json")

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
    expect(page).to have_css(".follower", count: 3)

    within(first(".follower")) do
      expect(page).to have_css(".handle")
    end
  end
end
