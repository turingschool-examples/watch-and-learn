# frozen_string_literal: true

require 'rails_helper'

describe 'As a registered user' do
  it 'I can confirm my email', :vcr do
    user_1 = create(:user)
    token = user_1.confirm_token

    visit "http://localhost:3000/users/#{token}/confirm_email"

    expect(current_path).to eq(welcome_path)
    expect(page).to have_content('Thank you! Your account is now activated.')
  end

  it 'I cant confirm urecognized token', :vcr do
    user_1 = create(:user)

    visit 'http://localhost:3000/users/aaddwrongToken/confirm_email'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Sorry, User does not exist')
  end
end
