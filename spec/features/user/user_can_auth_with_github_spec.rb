require 'rails_helper'

describe 'a user can authenticate with github' do
  it 'allows a user to authorize app to use github account' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    click_on "Connect to Github"
    OmniAuth.config.test_mode = true
    #OAuth stuff happens

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      #:uid => '123545'
    })

    expect(current_path).to eq(dashboard_path)
  end
end

# As a user
# When I visit /dashboard
# Then I should see a link that is styled like a button that says "Connect to Github"
# And when I click on "Connect to Github"
# Then I should go through the OAuth process
# And I should be redirected to /dashboard
# And I should see all of the content from the previous Github stories (repos, followers, and following)
