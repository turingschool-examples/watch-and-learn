require 'rails_helper'

describe 'User' do

  before :each do
    @user = create(:user, token: ENV["GH_API_KEY"])
  end


  it 'A logged in user visits /dashboard sees section for Github' do
    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password

    click_on 'Log In'
    # binding.pry

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(@user.email)
    expect(page).to have_content(@user.first_name)
    expect(page).to have_content(@user.last_name)

    expect(page).to have_css(".repo", count:1)
    expect(page).to have_content("5 Recent Repos")
  end

  it "show page will display different github repos based off token" do
    user_2 = User.create!(email: 'blah@example.com', first_name: 'User_2', last_name: 'Regular_2', password:  "password", role: 0, token: ENV["2_GH_API_KEY"])

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user_2.email
    fill_in 'session[password]', with: user_2.password
    click_on 'Log In'


    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(user_2.email)
    expect(page).to have_content(user_2.first_name)
    expect(page).to have_content(user_2.last_name)

    expect(page).to have_css(".repo", count:1)
    expect(page).to have_content("5 Recent Repos")
  end

  it 'A new logged in user visits /dashboard and sees different repos from GH' do 
    user_2 = create(:user, token: ENV["2_GH_API_KEY"])

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user_2.email
    fill_in 'session[password]', with: user_2.password
    
    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(user_2.email)
    expect(page).to have_content(user_2.first_name)
    expect(page).to have_content(user_2.last_name)
    
    expect(page).to have_css(".repo", count:1)
    expect(page).to have_content("5 Recent Repos")
  end
end

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5
# repositories with the name of each Repo linking to the repo on Github
