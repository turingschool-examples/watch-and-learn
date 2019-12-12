require 'rails_helper'

describe 'About show page' do
  describe 'as a visitor' do
    it 'I can see a summary of the app' do
      visit '/about'

      expect(page).to have_content('Turing Tutorials')
    end
  end
end
