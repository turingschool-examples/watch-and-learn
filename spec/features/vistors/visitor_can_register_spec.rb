# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor registration' do
  before do
    @email = 'jimbob@aol.com'
    @first_name = 'Jim'
    @last_name = 'Bob'
    @password = 'password'
    @password_confirmation = 'password'
  end

  describe 'vistor can create an account', :js do
    it ' visits the home page' do
      visit '/'

      click_on 'Sign In'

      expect(page.has_current_path?(login_path)).to be(true)

      click_on 'Sign up now.'

      expect(page.has_current_path?(new_user_path)).to be(true)

      fill_in 'user[email]', with: @email
      fill_in 'user[first_name]', with: @first_name
      fill_in 'user[last_name]', with: @last_name
      fill_in 'user[password]', with: @password
      fill_in 'user[password_confirmation]', with: @password

      click_on'Create Account'

      expect(page.has_current_path?(dashboard_path)).to be(true)

      expect(page.has_content?(@email)).to be(true)
      expect(page.has_content?(@first_name)).to be(true)
      expect(page.has_content?(@last_name)).to be(true)
      expect(page.has_content?('Sign In')).to be(false)
    end
  end

  it 'visitor cannot create an account if the email they enter is taken' do
    create(:user, email: @email)

    visit '/'

    click_on 'Sign In'

    expect(page.has_current_path?(login_path)).to be(true)

    click_on 'Sign up now.'

    expect(page.has_current_path?(new_user_path)).to be(true)

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_on'Create Account'

    expect(User.all.count).to eq(1)
    expect(page.has_content?('Email already exists')).to be(true)
  end
end
