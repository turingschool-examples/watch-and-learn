# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end
    end

    it 'shows an about page' do
      visit root_path

      click_on 'About'

      expect(current_path).to eq(about_path)
      expect(page).to have_content('This application is designed to pull in youtube information')
    end

    it 'shows a get started page' do
      visit root_path

      click_on 'Get Started'

      expect(current_path).to eq(get_started_path)
      within '.started-main' do
        expect(page).to have_content('Browse tutorials from')
        expect(page).to have_link('Sign in')
      end
    end
  end
end
