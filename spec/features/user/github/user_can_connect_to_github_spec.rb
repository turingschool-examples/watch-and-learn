require 'rails_helper'

describe 'as a user on the dashboard screen' do
  before(:each) do
    @uid = '12345'
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      'credentials' => {'token' => ENV['GITHUB_API_KEY']},
      'uid' => @uid
      # etc.
    })
  end
  it 'can connect to Github' do
    user_1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit '/dashboard'

    VCR.use_cassette("services/find_repositories") do
      VCR.use_cassette("services/find_followers") do
        VCR.use_cassette("services/find_followings") do
          click_on 'Connect Your Github'
        end
      end
    end

    expect(page).to have_content("Your Github:")
    expect(page).to have_css(".repo", count: 5)

    expect(user_1.reload.github_uid).to eq(@uid)
  end
end
