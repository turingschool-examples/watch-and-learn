require 'rails_helper'

describe "As a user" do
  # before do
  #   OmniAuth.config.add_mock(:github, {:uid => ENV['GITHUB_API_TOKEN_R'], :username => "Rostammahabdi", :token => "123412341234"})
  #   visit '/auth/github/callback'
  # end
  xit "shows a link to connect to github on dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'

    expect(page).to have_link("Connect to Github")
  end

  xit "allows the user to login via github authorization" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    OmniAuth.config.add_mock(:github, {:uid => ENV['GITHUB_API_TOKEN_R'], :username => "Rostammahabdi", :token => "123412341234"})
    visit '/auth/github/callback'
    expect(user.username).to eq("Rostammahabadi")
    expect(user.user_id).to eq('60719241')
    expect(user.token).to eq("123412341234")
  end

end
