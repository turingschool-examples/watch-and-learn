require 'rails_helper'

feature 'as a user when i visit my dashboard' do
  scenario 'Links show up next to followers that have accounts in our system.' do
    stub_dashboard_api_calls
    user_1 = create(:user, token: ENV['GITHUB_API_KEY'])
    user_1.update(login: "madeuploginid")
    user_2 = create(:user, login: "icorson3")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    within(first(".followers")) do
      expect(page).to have_link("Add Friend")
    end

    within(first(".following")) do
      expect(page).to have_link("Add Friend")
    end

    within ".following_name", match: :first do
      click_link "Add Friend"
    end
    expect(user_1.friends).to eq([user_2])
    # expect(user_1.friends.count).to eq(1)
  end
end
