require 'rails_helper'

describe 'User Dashboard' do
  it 'displays users repos' do
    user1 = create(:user, github_token: ENV["GITHUB_ACCESS_TOKEN"])
    user2 = create(:user, github_token: ENV["SECOND_GITHUB_ACCESS_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit login_path

    fill_in'session[email]', with: user1.email
    fill_in'session[password]', with: user1.password
    click_on 'Log In'
    expect(current_path).to eq(dashboard_path)
    within('.github') do 

        expect(page).to have_css('.repo', count: 5)
        expect(page).to have_content("futbol")
        expect(page).to_not have_content("the_final_rose")
    end 

  end 

  it 'does not display if user has no github token' do 
    user1 = create(:user)
    visit login_path

    fill_in'session[email]', with: user1.email
    fill_in'session[password]', with: user1.password
    click_on 'Log In'
    expect(current_path).to eq(dashboard_path)
save_and_open_page
    expect(page).to_not have_css('.github')
  end

end 




# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github