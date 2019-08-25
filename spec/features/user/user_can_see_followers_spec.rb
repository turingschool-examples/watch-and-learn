require 'rails_helper'

feature 'as a user when I visit my dashboard' do
  scenario 'I see everyone who follows me and their GH handle is a link to their profile' do
    stub_dashboard_api_calls

    user = create(:user)
    user.token = ENV['GITHUB_API_KEY']
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Github")
    expect(page).to have_content("Followers")
    expect(page).to have_css(".follower_name", count: 4)

    within ".followers" do
      expect(page).to have_link("ryanmillergm")
      expect(page).to have_link("Jake0Miller")
      expect(page).to have_link("tbierwirth")
      expect(page).to have_link("nathangthomas")
    end
  end
end
