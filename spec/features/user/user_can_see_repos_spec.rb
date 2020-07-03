require 'rails_helper'

describe 'User Dashboard' do
  it 'displays users repos' do
    user = create(:user)
    binding.pry
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
 
    within('.github') do 
        expect(page).to have_css('.repo', count: 5)
    end 

  end 
end 




# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github