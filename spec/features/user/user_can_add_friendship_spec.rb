require 'rails_helper'

feature 'as a user when I visit my dashboard' do
  scenario 'I can add followers/following as friends if they have a GH account' do
    stub_dashboard_api_calls
    stub_github_oauth

    josh = create(:user, token: ENV["GITHUB_API_KEY"])
    josh.update(html_url: "https://github.com/glynnisoc")
    dani = create(:user, token: ENV["GITHUB_API_KEY_2"])
    dani.update(html_url: "https://github.com/ryanmillergm")
    madi = create(:user)
    madi.update(html_url: "https://github.com/Jake0Miller")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(josh)

    visit dashboard_path

    within ".followers" do
      expect(page).to have_link("Add as a Friend")
    end

    within (page.all('.follower_name')[2]) do
      expect(page).to_not have_link("Add as a Friend")
    end

    within ".following" do
      expect(page).to have_link("Add as a Friend")
    end

    within ".follower_name", match: :first do
      click_link "Add as a Friend"
    end
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Friend Added!")
    josh.reload
    expect(josh.friends.first).to eq(dani)
    expect(josh.friendships.count).to eq 1

    expect(page).to have_content("Friends")
    within ".friends" do
      expect(page).to have_content(dani.first_name)
    end
  end
end
