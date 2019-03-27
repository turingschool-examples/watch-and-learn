require 'rails_helper'

RSpec.describe 'About show page' do
  describe 'content' do
    it 'has a title' do
      visit about_path

      expect(page).to have_content("Turing Tutorials")
    end
    it 'has a paragraph description' do
      visit about_path

      expect(page).to have_content("This application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel. It's designed for anyone learning how to code, with additional features for current students.")
    end
    it 'has a link to get started' do
      visit about_path

      expect(page).to have_link("Get Started", href: get_started_path)

      click_on "Get Started"

      expect(current_path).to eq(get_started_path)
    end
  end

  describe 'As any kind of user' do
    it 'can see about page' do
      visit '/'

      click_on 'About'

      expect(current_path).to eq(about_path)

      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      click_on 'About'

      expect(current_path).to eq(about_path)

      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/'

      click_on 'About'

      expect(current_path).to eq(about_path)
    end
  end
end
