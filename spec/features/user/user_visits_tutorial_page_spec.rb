require 'rails_helper'

describe 'As a user' do
  describe 'When I visit a tutorial show page that has no videos' do
    it 'shows a message stating that the tutorial is empty' do
      user = create(:user)
      tutorial = create(:tutorial)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit tutorial_path(tutorial)

      expect(page).to have_content('No Videos')
      expect(page).to have_content('Check back soon!')
    end
  end
end
