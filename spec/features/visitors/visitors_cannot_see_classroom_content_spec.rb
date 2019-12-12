require 'rails_helper'

describe 'Tutorial index page' do
  describe 'As a visitor' do
    it "can't see classroom tutorials" do
      tutorial = create(:tutorial)
      tutorial_2 = create(:tutorial, classroom: true)
      tutorial_3 = create(:tutorial, classroom: true)

      visit root_path

      expect(page).to have_content(tutorial.title)
      expect(page).to_not have_content(tutorial_2.title)
      expect(page).to_not have_content(tutorial_3.title)

      visit "/tutorials/#{tutorial.id}"

      expect(page).to have_content('No videos currently')

      visit "/tutorials/#{tutorial_2.id}"

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
