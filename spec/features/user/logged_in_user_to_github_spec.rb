require 'rails_helper'

describe 'User' do
  it 'A logged in user visits /dashboard sees section for Github' do
    user = create(:user)

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)

    expect(page).to have_css(".repo", count:5)
    expect(page).to have_content("5 Results")

    within(first(".repo")) do 
      expect(page).to have_css(".name")
    end
  end
end

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 
# repositories with the name of each Repo linking to the repo on Github