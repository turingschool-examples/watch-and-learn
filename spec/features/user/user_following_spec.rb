require 'rails_helper'

feature 'as a user when I visit my dashboard' do
  scenario 'I see all users I am following on GH' do
    stub_dashboard_following_api_calls

    WebMock.allow_net_connect!
    VCR.turn_off!

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Github")
    expect(page).to have_content("Followers")
    expect(page).to have_content("Following")

    expect(page).to have_link("Jake0Miller")
    expect(page).to have_link("tbierwirth")
    expect(page).to have_link("nathangthomas")
  end
end
