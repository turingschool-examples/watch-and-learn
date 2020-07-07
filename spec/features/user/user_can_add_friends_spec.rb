require 'rails_helper'

describe "user has a follower that also oauth'd via github" do
  it "displays 'add friend' next to oauth'd followers name" do
    user1 = create(:user)
    user2 = create(:user)
    user1.update_attribute(:token, ENV['GITHUB_TOKEN'])
    user2.update_attribute(:token, ENV['MICHAELS_TOKEN'])
    user1.update_attribute(:ghub_username, "whitneykidd")
    user2.update_attribute(:ghub_username, "Gallup93")

    visit "/login"

    click_on "Sign In"

    fill_in 'session[email]', with: user1.email
    fill_in 'session[password]', with: user1.password

    click_on 'Log In'

    expect(current_path).to eq("/dashboard")

    within ".follow" do
      click_link "Add friend"
    end

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Added friend.")

    within ".follow" do
      expect(page).to_not have_link("Add friend")
    end
  end
end
