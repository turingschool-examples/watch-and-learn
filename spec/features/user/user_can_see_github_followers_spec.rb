require 'rails_helper'

describe 'Github followers' do

  before :each do
    @user = create(:user, token: ENV["GH_API_KEY"])
  end

  it "user can see 5 of their followers on github" do
    visit '/'
    click_on "Sign In"
    expect(current_path).to eq(login_path)
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_on 'Log In'

    within ".github_followers" do
      expect(page).to have_content("5 Followers")
    end

    #test that they are links
  end
end
