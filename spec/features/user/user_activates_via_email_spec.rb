# frozen_string_literal: true

require 'rails_helper'

describe 'user can create an account', :js do
  it ' the home page' do
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

    expect { click_on 'Create Account' }
      .to change { ActionMailer::Base.deliveries.count }.by(1)

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Logged in as #{first_name}")
    expect(page).to have_content('This account has not yet been activated.')

    # Registered but not actived user has received email with link to click
    visit "/activation?email=#{User.find_by(email: email).email}"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Thank you! Your account is now activated.')
    expect(User.find_by(email: email).reload.active).to eq(true)
  end
end
