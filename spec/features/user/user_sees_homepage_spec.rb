# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      user = create(:user)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      tutorial1 = create(:tutorial, classroom: false)
      tutorial2 = create(:tutorial, classroom: true)

      create(:video, tutorial_id: tutorial1.id)
      create(:video, tutorial_id: tutorial1.id)
      create(:video, tutorial_id: tutorial2.id)
      create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end
    end
  end
end
