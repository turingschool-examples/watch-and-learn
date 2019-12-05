require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the home page' do
    before :each do
      @tutorial_1 = create(:tutorial)
      @tutorial_2 = create(:tutorial, classroom: true)
      visit '/'
    end
      
    it 'I only see tutorials that are not marked as "classroom content"' do
      expect(page).to have_content(@tutorial_2.title)
      expect(page).to_not have_content(@tutorial_1.title)
    end
  end
end