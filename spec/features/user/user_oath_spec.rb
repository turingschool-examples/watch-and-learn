require 'rails_helper'

describe "User Oath funtionality" do
  it "can see a link" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    expect(page).to have_link("Connect to Github")
  end
  it "testing for omnioath" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :credentials => {"token" => ENV["GITHUB_API_KEY"]},
      :info => {"nickname" => "funny guy"}
      })
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"
    click_on "Connect to Github"

    expect(page.status_code).to eq(200)
  end
end
