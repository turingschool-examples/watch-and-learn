require 'rails_helper'

feature 'as a user when I visit my dashboard' do
  scenario 'I can see a list of all bookmarked videos organized by tutorial and ordered by position' do
    stub_dashboard_api_calls
    stub_github_oauth

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_link "Connect to Github"

    save_and_open_page

    expect(current_path).to eq(dashboard_path)


    expect(page).to have_css(".tutorial", count: 5)

    within(first(".tutorial")) do
      expect(page).to have_css(".video")
    end
  end
end

# As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position
