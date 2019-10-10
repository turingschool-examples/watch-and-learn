require 'rails_helper'

describe 'User Dashboard' do

  before :each do
    repo_json_response = File.open('./spec/fixtures/github_repo_data.json')

    stub_request(:get, "https://api.github.com/user/repos")
    .to_return(status: 200, body: repo_json_response)

    follower_json_response = File.open('./spec/fixtures/github_follower_data.json')

    stub_request(:get, "https://api.github.com/user/followers")
    .to_return(status: 200, body: follower_json_response)

    following_json_response = File.open('./spec/fixtures/github_following_data.json')

    stub_request(:get, "https://api.github.com/user/following")
    .to_return(status: 200, body: following_json_response)
  end

  it 'displays Github repos' do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_css(".github-repositories")

    within ".github-repositories" do
      expect(page).to have_link("repo_1")
      expect(page).to have_link("repo_2")
      expect(page).to have_link("repo_3")
      expect(page).to have_link("repo_4")
      expect(page).to have_link("repo_5")

    end
  end

  it 'displays Github followers' do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_css(".github-followers")

    within ".github-followers" do
      expect(page).to have_link("Kate-v2")
      expect(page).to have_link("matthewdshepherd")
      expect(page).to have_link("Garrett-Iannuzzi")
    end
  end

  it 'displays Github following' do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_css(".github-following")

    within ".github-following" do
      expect(page).to have_link("alect47")
      expect(page).to have_link("corneliusellen")
      expect(page).to have_link("shaviland")
    end
  end
end
