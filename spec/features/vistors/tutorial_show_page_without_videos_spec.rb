require 'rails_helper'

describe 'Tutotrial page still loads without videos' do
  describe 'as any user' do
    it 'will display a message that there are no videos on show page' do
      tutorial = create(:tutorial)

      visit tutorial_path(tutorial)

      expect(page).to have_content('No videos currently')
    end
  end
end
