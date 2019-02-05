require 'rails_helper'

describe "As Visitor when you register" do
  it "can send registration email to non-activated user to register" do
    clear_emails
    email = 'test@example.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'
    click_on 'Sign up now.'

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'
    user = User.last
    expect(user.activated).to eq(false)

    open_email("test@example.com")
    expect(current_email).to have_content("Visit here to activate your account.")
    current_email.click_link("here")
    expect(page).to have_content("Status Active")
    expect(current_path).to eq(dashboard_path)
  end
end
