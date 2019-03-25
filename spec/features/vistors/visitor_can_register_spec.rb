require 'rails_helper'

describe 'vistor can create an account', :js do
  it ' visits the home page' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    @user = User.last
    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("You are logged in as #{email}, but your account is not yet active. Please check your email and click the registration link to continue.")
    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to have_content("Status: Unactivated. Please check your email to complete registration.")
    expect(page).to_not have_content('Sign In')

    visit confirm_email_user_path(@user.confirm_token)

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Thank you for registering! Your account is now active.")
    expect(page).to have_content("Status: Active")
  end
end
