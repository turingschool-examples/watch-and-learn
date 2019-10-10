require 'rails_helper'

describe "OmniAuth Sign In" do
  it "A user can sign in to GitHub via OmniAuth", :vcr do
    json_response = File.open('./fixtures/github_repo_data.json')
    stub_request(:get, 'https://api.github.com/user/repos').to_return(status: 200, body: json_response)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    stub_omniauth
    visit dashboard_path
    expect(page).to have_link("Connect to Github")
    click_link("Connect to Github")
    expect(page).to have_content("Github Section")
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] =
    OmniAuth::AuthHash.new({
      "provider"=>"github",
      "uid"=>"45922590",
      "credentials"=>{"token"=>"86dc73ab292cebe9f8ebd27644ce1848b5a863d2", "expires"=>false
      }
      })
    end
end
