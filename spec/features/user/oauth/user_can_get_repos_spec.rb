require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  xit 'should let me see my repositories' do
    info =  [{id: 185445729, name: "activity-tracker-starter", html_url: "https://github.com/KirbyDD/activity-tracker-starter" },
    {id: 227461134, name: "adopt-dont-shop-two", html_url: "https://github.com/KirbyDD/adopt-dont-shop-two" }].to_json
    user = create(:user, github_token: ENV["TEST_API_KEY"], uid: 36940278)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    stub_request(:get, "https://api.github.com/users/KirbyDD/repos").
    to_return(status: 200, body: info, headers: {})
    visit '/'
    click_on 'Github'
    save_and_open_page
    expect(page).to have_link("activity-tracker-starter")
    expect(page).to have_content("Repo Name: activity-tracker-starter")
  end
end
