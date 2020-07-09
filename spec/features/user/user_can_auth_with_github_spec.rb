require 'rails_helper'

describe 'a user can authenticate with github' do
  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = nil
  end
  it 'allows a user to authorize app to use github account', :vcr do
    user = create(:user)
    credential_mock_hash = {token: ENV["GITHUB_TOKEN_A"]}
    info_mock_hash = {name: "name", nickname: "another name"}
    OmniAuth.config.add_mock(:github, {credentials: credential_mock_hash, info: info_mock_hash })
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_on "Connect to Github"

    expect(current_path).to eq(dashboard_path)
    expect(User.find(user.id).github_token).to eq(ENV["GITHUB_TOKEN_A"])
    expect(User.find(user.id).github_username).to eq("another name")
  end
end
