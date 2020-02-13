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


      visit('/dashboard')
      user.status = 'active'
    # visit "/users/#{user.confirm_token}/confirm_email"
    # visit "/#{user.confirm_token}/confirm_email"
    # expect(page).to have_content('Active')
  end
end
