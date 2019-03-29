# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'user can sign in' do
    user = create(:user)

    visit '/'

    click_on 'Sign In'

    expect(page.has_current_path?(login_path)).to be(true)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page.has_current_path?(dashboard_path)).to be(true)
    expect(page.has_content?(user.email)).to be(true)
    expect(page.has_content?(user.first_name)).to be(true)
    expect(page.has_content?(user.last_name)).to be(true)
  end

  it 'can log out', :js do
    user = create(:user)

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    click_on 'Profile'

    expect(page.has_current_path?(dashboard_path)).to be(true)

    click_on 'Log Out'

    expect(page.has_current_path?(root_path)).to be(true)
    expect(page.has_content?(user.first_name)).to be(false)
    expect(page.has_content?('SIGN IN')).to be(true)
  end

  it 'is shown an error when incorrect info is entered' do
    create(:user)
    fake_email = 'email@email.com'
    fake_password = '123'

    visit login_path

    fill_in'session[email]', with: fake_email
    fill_in'session[password]', with: fake_password

    click_on 'Log In'

    expect(page).to have_content('Looks like your email or password is invalid')
  end
end
