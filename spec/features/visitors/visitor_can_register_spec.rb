require 'rails_helper'

describe 'visitor can create an account', :js, :vcr do
  it 'visits the home page' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'

    visit '/'

    click_link 'Sign In'

    expect(current_path).to eq(login_path)

    click_link 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_button 'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
    expect(page).to have_content("Signed in as #{first_name}")
    expect(page).to have_content('This account has not yet been activated. Please check your email.')
    expect(page).to have_content('Status: Inactive')
  end

  it "cannot create an account with existing username" do
    User.create!(email: 'user_1@example.com', first_name: 'Brian', last_name: 'B', password: "password1")
    email = 'user_1@example.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'

    visit '/register'

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'

    expect(page).to have_content("Username already exists")
  end
end
