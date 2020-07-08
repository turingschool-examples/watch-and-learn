require 'rails_helper'

describe 'User' do
  it "can follow link from email to activate account" do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'

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

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Logged in as Jim")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
    expect(page).to have_content("Status: Inactive")

    visit "/send_confirmation"

    visit "/confirmed"

    expect(current_path).to eq("/activated")

    expect(page).to have_content("Thank you! Your account is now activated.")

    click_link "Go To Your Dashboard"

    expect(page).to have_content("Jim's Dashboard")
    expect(page).to have_content("Status: Active")
  end
end
