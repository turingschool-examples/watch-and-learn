require 'rails_helper'

describe '/dashboard page' do
# describe '/dashboard page', :vcr do
  it 'show repos - happy' do
    user = create(:user, token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette('repos_happy') do
      visit '/dashboard'

      expect(page).to have_content("Github Repos")
      within "#repos" do
        expect(page).to have_css('#dot', count: 5)
      end
    end
  end

  it 'show repos - sad' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to_not have_content("Github Repos")
    expect(page).to_not have_css('#repos')
  end

  it 'shows followers name and a link to their homepage' do
    user = create(:user, token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette('followers') do
      visit '/dashboard'
      expect(page).to have_content('Github Followers')
    end
  end
end
