require 'rails_helper'

describe 'as a logged in user' do
  it 'sees add friend link next to followers and following' do
    user = create(:user, token: ENV["GITHUB_API_KEY"])
    user_2 = create(:user, github_username: ENV["FRIEND_1"])
    user_3 = create(:user, github_username: ENV["FRIEND_2"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within(".github") do
      within(all(".follower").first) do
        click_on "Add as Friend"
      end
    end

    expect(current_path).to eq('/dashboard')

    within(".github") do
      within(all(".follower").first) do
        expect(page).to have_no_content("Add as Friend")
      end
    end

    within(".github") do
      within(all(".followee").first) do
        click_on "Add as Friend"
        expect(current_path).to eq('/dashboard')
      end
    end

    within(".github") do
      within(all(".followee").first) do
        expect(page).to have_no_content("Add as Friend")
      end
    end

    within(".github") do
      within(all(".followee")[1]) do
        expect(page).to have_no_content("Add as Friend")
      end
    end
  end
end
