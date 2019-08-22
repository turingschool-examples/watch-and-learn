require 'rails_helper'

feature 'Github Repos' do
  scenario 'User can see 5 repos' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("synopsis") do
      visit '/dashboard'
    end

    expect(current_path).to eq(dashboard_path)

    within('#repos') do
      expect(page).to have_css(".repo", count: 5)
      within(first(".repo")) do
        expect(page).to have_link("JoriPeterson/battleship")
      end
    end
  end
end
