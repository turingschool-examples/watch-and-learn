require 'rails_helper'

describe 'As a user on my dashboard' do
  it 'I can see who I am following on GitHub', :vcr do
    token = ENV['GITHUB_TOKEN_LOCAL']
    user = create(:user, token: token)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('Followers On Github')
    expect(page).to have_css('.followers', count: 3)

    within(first('.followers')) do
      expect(page).to have_css('.name')
    end

    click_button 'Log Out'

    expect(page).not_to have_css(".followers")
  end
end
