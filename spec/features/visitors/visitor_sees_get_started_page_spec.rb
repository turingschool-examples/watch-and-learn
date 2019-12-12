require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'will display the get started page' do

    visit '/get_started'

    within '.started-header' do
      expect(page).to have_content('Get Started')
    end
  end
end
