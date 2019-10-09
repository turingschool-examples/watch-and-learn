require 'rails_helper'

describe 'User dashboard' do
  it "Users can see their github repos from their dashboard" do
    user = create(:user, gh_token: ENV['GITHUB_USER_TOKEN'])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    visit dashboard_path

    expect(page).to have_content("Your Github Repos")

    within '.repos' do
      expect(page).to have_css(".repo")
    end
  end

  it "A user without a github token will not display a github section" do
    user = create(:user)

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    visit dashboard_path

    expect(page).to_not have_content("Your Github Repos")
    expect(page).to_not have_css(".repos")
  end
end
