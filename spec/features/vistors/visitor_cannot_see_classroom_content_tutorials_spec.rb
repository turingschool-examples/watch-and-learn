require 'rails_helper'

describe 'visitor visits welcome page' do
  it 'I cannot see tutorials labeled classroom content' do
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial, classroom: true)

    visit root_path

    within(first('.tutorials')) do
      expect(page).to have_content(tutorial1.title)
      expect(page).to have_no_content(tutorial2.title)
    end
  end
end