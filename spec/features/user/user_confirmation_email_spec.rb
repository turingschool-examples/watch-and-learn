# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User must' do
  it 'verify their email' do
    user = create(:user)

    visit('/')

    click_on 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log In'

    expect(page).to have_content('Inactive')

    user.update(email_confirmed: true)

    visit('/dashboard')

    expect(page).to have_content('Active')
  end
end
