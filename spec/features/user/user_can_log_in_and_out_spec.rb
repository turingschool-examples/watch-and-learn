require 'rails_helper'

describe 'User' do
  it 'user can sign in', :vcr do
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
  end

  it 'can log out', :js, :vcr do
    user = create(:user)

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    click_on 'Profile'

    expect(current_path).to eq(dashboard_path)

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content(user.first_name)
    expect(page).to have_content('SIGN IN')
  end

  it 'is shown an error when incorrect info is entered', :vcr do
    user = create(:user)
    fake_email = "email@email.com"
    fake_password = "123"

    visit login_path

    fill_in'session[email]', with: fake_email
    fill_in'session[password]', with: fake_password

    click_on 'Log In'

    expect(page).to have_content("Looks like your email or password is invalid")
  end

  it 'user can sign in', :vcr do
    email = "shani@satterfieldwehner.info"
    first_name = "Tyson"
    last_name = "Magritte"
    password = "password"
    user_name = first_name + " " + last_name

    visit '/'

    click_on "Register"

    expect(current_path).to eq('/register')
    expect(page).to have_content('Register')

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'
    
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{user_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end
end
