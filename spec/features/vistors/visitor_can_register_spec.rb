require 'rails_helper'

describe 'vister can create an account' do
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

    expect(current_path).to eq('/dashboard')

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
    expect(page).to have_content('Status: Inactive')
    expect(page).to have_content("Please verify your account.")
  end
  it "it will tell the user that they are signed in once they do so" do


    user_2 = User.create(
      email: "user_2@email.com",
      first_name: "Stella",
      last_name: "Jimster",
      password: "password",
      role: 0,
      uid: 55362003,
      email_confirmation: true
    )

      visit "/"
      click_on "Sign In"
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: "user_2@email.com"
      fill_in 'session[password]', with: "password"
      click_on 'Log In'


      expect(page).to have_content("Status: Active")

    end

  end
