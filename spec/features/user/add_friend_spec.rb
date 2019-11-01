require 'rails_helper'

RSpec.describe "User dashboard", type: :feature do
  before :each do
    stub_omniauth
    stub_json("https://api.github.com/user/repos", "./fixtures/repositories.json")
    stub_json("https://api.github.com/user/followers", "./fixtures/followers.json")
    stub_json("https://api.github.com/user/following", "./fixtures/following.json")

    user = create(:user)
    user_cred = create(:user_credential, user_id: user.id)
    user_cred2 = create(:user_credential, nickname: "Bozotte")
    user_cred3 = create(:user_credential, nickname: "sole")

    visit '/'
    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'
  end

  it "user sees 'add as friend' next to followers with accounts" do
    expect(page).to have_css(".follower", count: 5)

    expect(first('.follower')).to have_button("Add as Friend")
  end

  it "user sees 'add as friend' next to followings with accounts" do
    expect(page).to have_css(".follow", count: 5)

    expect(first('.follow')).to have_button("Add as Friend")
  end
end