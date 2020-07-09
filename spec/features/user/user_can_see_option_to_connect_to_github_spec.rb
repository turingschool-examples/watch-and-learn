require 'rails_helper'

describe "As a user" do
  before :each do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :info => {:email => 'RostamMahabadi@gmail.com', :nickname => "Rostammahabadi", :uid => "60719241", :token => "123412341234"},
      :credentials => {:token => ENV['GITHUB_API_TOKEN_R']}
    })
  end
  it "shows a link to connect to github on dashboard" do

    visit '/dashboard'

    expect(page).to have_link("Connect to Github")
  end

  xit "allows the user to login via github authorization" do

    visit dashboard_path

    click_on "Connect to Github"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css('.github-followers')
    expect(page).to have_css('.github-following')
  end

end
