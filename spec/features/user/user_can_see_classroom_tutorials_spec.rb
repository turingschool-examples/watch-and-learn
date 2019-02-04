require 'rails_helper'

describe 'As a user' do
  describe 'when logged in' do
    describe 'when visiting the home page' do
      it 'shows tutorials listed as class content' do
        tutorial1 = create(:tutorial, classroom: true)
        tutorial2 = create(:tutorial, classroom: true)
        tutorial3 = create(:tutorial)
        tutorial4 = create(:tutorial)

        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit root_path

        expect(page).to have_css('.tutorial', count: 4)

        within(first('.tutorials')) do
          expect(page).to have_css('.tutorial')
          expect(page).to have_css('.tutorial-description')
          expect(page).to have_content(tutorial1.title)
          expect(page).to have_content(tutorial1.description)
        end
      end
    end
  end
end
