require 'rails_helper'

describe 'as a user on the dashboard screen' do
  before(:each) do
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '12345'
      # etc.
    })
  end
  it 'can connect to Github' do

    Capybara.app = OauthWorkshop::Application

    visit '/dashboard'

    click_on 'Connect Your Github'
    require 'pry'; binding.pry

  end
end
