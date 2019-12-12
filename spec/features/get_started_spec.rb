require 'rails_helper'

describe 'Get started show page' do
  describe 'as a visitor' do
    it 'I can see instructions to help navigate the app' do
      visit '/get_started'
      
      expect(page).to have_content('Get Started')
    end
  end
end
