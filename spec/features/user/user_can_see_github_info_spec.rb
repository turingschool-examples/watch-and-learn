require 'rails_helper'

RSpec.describe 'As a user' do
  before :each do
    user = create(
      :user,
      email: 'user_2@example.com',
      password: 'password',
      github_token: ENV['GITHUB_TOKEN_1']
    )

    visit '/'

    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log In'
  end

  it 'can view github repos in github section on dashboard', :vcr do
    expect(current_path).to eq('/dashboard')

    within(first('.repo')) do
      expect(page).to have_css('.name')
    end
  end

  it 'can view github followings in github section on dashboard', :vcr do
    expect(current_path).to eq('/dashboard')

    within(first('.following')) do
      expect(page).to have_css('.login')
    end
  end

  it 'can view github followers in github section on dashboard', :vcr do
    expect(current_path).to eq('/dashboard')

    within(first('.followers')) do
      expect(page).to have_css('.login')
    end
  end
end
