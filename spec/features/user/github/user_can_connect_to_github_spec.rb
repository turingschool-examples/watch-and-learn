require 'rails_helper'

describe 'as a user on the dashboard screen' do
  xit 'can connect to Github' do
    Capybara.app = OauthWorkshop::Application

    visit '/dashboard'

    click_on 'Connect Your Github'


  end
end
