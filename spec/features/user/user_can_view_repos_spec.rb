require 'rails_helper'

RSpec.describe 'As a logged in user', type: :feature do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When I visit /dashboard' do
    before(:each) do
      visit '/dashboard'
    end

    it 'Then I should see a section for "Github"' do
      expect(page).to have_css('h1', text: "Your GitHub Repos")
    end

    it 'And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github' do
      within('#repos') do
        expect(page).to have_css('li', count: 5)
        expect(page).to have_css('li::nth-of-type(1)', text: 'activerecord-obstacle-course')
        expect(page).to have_css('li::nth-of-type(2)', text: 'adopt_dont_shop')
        expect(page).to have_css('li::nth-of-type(3)', text: 'adopt_dont_shop_paired')
        expect(page).to have_css('li::nth-of-type(4)', text: 'backend-curriculum-site')
        expect(page).to have_css('li::nth-of-type(5)', text: 'backend_module_0_capstone')
        expect(page).to have_link('activerecord-obstacle-course', href: "https://github.com/DanielEFrampton/activerecord-obstacle-course")
        expect(page).to have_link('adopt_dont_shop', href: "https://github.com/DanielEFrampton/adopt_dont_shop")
        expect(page).to have_link('adopt_dont_shop_paired', href: "https://github.com/DanielEFrampton/adopt_dont_shop_paired")
        expect(page).to have_link('backend-curriculum-site', href: "https://github.com/DanielEFrampton/backend-curriculum-site")
        expect(page).to have_link('backend_module_0_capstone', href: "https://github.com/DanielEFrampton/backend_module_0_capstone")
      end
    end
  end
end
