require 'rails_helper'

describe 'As a user on my dashboard' do
  before :each do
    token = ENV["GITHUB_TOKEN_LOCAL"]
    @user = create(:user, token: token)
  end

  it 'I can see a list of my GitHub repos', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path
    expect(page).to have_content('Personal Repos')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css(".repos", count: 5)
    within(first(".repos")) do
      expect(page).to have_css(".name")
    end
  end

  it 'I can see a list of who I am following on GitHub', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    expect(page).to have_content('Following On Github')

    within(first(".following")) do
      expect(page).to have_css(".name")
    end

    click_on "Log Out"

    expect(page).not_to have_css(".repos")
    expect(page).not_to have_css(".following")
  end

  it 'I can see a list of who follows me on GitHub', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    expect(page).to have_content('Followers On Github')

    within(first('.followers')) do
      expect(page).to have_css('.name')
    end

    click_button 'Log Out'

    expect(page).not_to have_css(".followers")
  end
end
