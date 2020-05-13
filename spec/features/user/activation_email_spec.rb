require 'rails_helper'

describe "activation email" do
  it "as a visitor registering, I should get an email to activate account" do
    email = 'davidttemail@gmail.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Register'

    expect(current_path).to eq(register_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'

    expect(page).to have_current_path("/dashboard")
    expect(page).to have_content("Logged in as #{first_name} #{last_name}.")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
    expect(page).to have_no_content("Status: Active")
  end
end
