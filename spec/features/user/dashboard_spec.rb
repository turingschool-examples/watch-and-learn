require 'rails_helper'

describe "User dashboard", type: :feature do
  before :each do
    repos_json = File.open("./fixtures/repositories.json")
    stub_request(:get, 'https://api.github.com/user/repos').
    to_return(status: 200, body: repos_json)

    followers_json = File.open("./fixtures/followers.json")
    stub_request(:get, 'https://api.github.com/user/followers').
    to_return(status: 200, body: followers_json)

    following_json = File.open("./fixtures/following.json")
    stub_request(:get, 'https://api.github.com/user/following').
    to_return(status: 200, body: following_json)

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'
    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
  end

  it '#sees repositories' do
    expect(page).to have_content("Github")

    expect(page).to have_css(".repository", count: 5)

    within(first(".repository")) do
      expect(page).to have_css(".name")
    end
  end

  it '#sees followers' do
    expect(page).to have_content("Followers")

    expect(page).to have_css(".follower", count: 5)

    within(first(".follower")) do
      expect(page).to have_css(".login")
    end
  end

  it '#sees following' do
    expect(page).to have_content("Following")

    expect(page).to have_css(".follow", count: 5)

    within(first(".follow")) do
      expect(page).to have_css(".login")
    end
  end
end