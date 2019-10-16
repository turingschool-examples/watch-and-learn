require 'rails_helper'

describe 'authorize user github' do

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

  it 'user can authorize app to use github data' do

    user = create(:user, github_token: nil)

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      { provider: "github",
        uid:"16658577",
        info:
        { nickname: "MackHalliday",
          email: nil,
          name: "Mack Halliday",
          image: "https://avatars2.githubusercontent.com/u/16658577?v=4",
          urls:
            { GitHub: "https://github.com/MackHalliday",
              Blog: "www.linkedin.com/in/mackenziehalliday"}},
        credentials:
          { token: "823fa3e72e05b186905ec6472f7baff0fd95640b",
            expires: false}})

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'


    expect(page).to_not have_css(".github-repositories")
    expect(page).to_not have_css(".github-followers")
    expect(page).to_not have_css(".github-following")

    within ".authorize-github" do
      click_button("Connect to Github")
    end

    expect(current_path).to eq(dashboard_path)

    within ".github-repositories" do
      expect(page).to have_link("repo_1")
      expect(page).to have_link("repo_2")
      expect(page).to have_link("repo_3")
    end

    within ".github-followers" do
      expect(page).to have_link("Kate-v2")
      expect(page).to have_link("matthewdshepherd")
      expect(page).to have_link("Garrett-Iannuzzi")
    end

    within ".github-following" do
      expect(page).to have_link("alect47")
      expect(page).to have_link("corneliusellen")
      expect(page).to have_link("shaviland")
    end

    expect(page).not_to have_button("Connect to Github")
  end

  it 'user cannot reauthorize github' do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_css(".github-repositories")
    expect(page).to have_css(".github-followers")
    expect(page).to have_css(".github-following")

    expect(page).not_to have_button("Connect to Github")
  end
end
