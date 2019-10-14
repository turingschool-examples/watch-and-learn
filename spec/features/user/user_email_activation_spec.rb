require 'rails_helper'

describe 'email activation' do
  it 'can activate account thru email' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Register'

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'

    user = User.last

    expect(user.account_registered).to eq(false)
    expect(page).to have_content("This account has not yet been activated. Please check your email.")

    ### Might need somthing here to test email went out ?

    visit "register/#{user.id}"

    user = User.last

    expect(page).to have_content("Thank you! Your account is now activated.")
    expect(user.account_registered).to eq(true)

    visit dashboard_path
    expect(page).to have_content("Status: Active")
  end
end
