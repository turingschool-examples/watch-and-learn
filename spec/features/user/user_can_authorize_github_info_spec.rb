require 'rails_helper'

describe 'As a logged in user' do
  before(:each) do
    OmniAuth.config.mock_auth[:github] = nil
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: '019039',
      credentials: {
        token: ENV['GITHUB_TOKEN']
      }
      })
  end
  it 'can see a link to connect to github', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_link('Connect to Github')
  end
  it 'can authorize info from github', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to_not have_css('.github')

    click_link "Connect to Github"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Github')
    expect(page).to have_content('Followers')
    expect(page).to have_content('Following')

    within '.github' do
      expect(page).to have_css('.repository', count: 5)
    end
  end
end
