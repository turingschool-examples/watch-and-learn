# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'user can sign in' do
    user = create(:user)

    visit '/'

    click_on "Sign In"

    expect(page).to have_current_path(login_path, ignore_query: true)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_current_path(dashboard_path, ignore_query: true)
    expect(page).to have_content("Logged as #{user.first_name} #{user.last_name}")
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
  end

  it 'can log out' do
    user = create(:user)

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    click_on 'Profile'

    expect(page).to have_current_path(dashboard_path, ignore_query: true)

    click_on 'Log Out'

    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).not_to have_content(user.first_name)
    # expect(page).to have_content('SIGN IN')
  end


  it 'is shown an error when incorrect info is entered' do
    user = create(:user)
    fake_email = "email@email.com"
    fake_password = "123"

    visit login_path

    fill_in'session[email]', with: fake_email
    fill_in'session[password]', with: fake_password

    click_on 'Log In'

    expect(page).to have_content("Looks like your email or password is invalid")
  end
end
