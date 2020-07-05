require 'rails_helper'

describe 'a user can authenticate with github' do
  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = nil
  end
  it 'allows a user to authorize app to use github account' do
    user = create(:user)
    credential_mock_hash = {token: "thisisamocktoken"}
    OmniAuth.config.add_mock(:github, {credentials: credential_mock_hash })
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_on "Connect to Github"

    expect(current_path).to eq(dashboard_path)
    expect(User.find(user.id).github_token).to eq("thisisamocktoken")
  end
end

# As a user
# When I visit /dashboard
# Then I should see a link that is styled like a button that says "Connect to Github"
# And when I click on "Connect to Github"
# Then I should go through the OAuth process
# And I should be redirected to /dashboard
# And I should see all of the content from the previous Github stories (repos, followers, and following)
