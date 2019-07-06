# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 3)


      click_link tutorial3.title

      expect(current_path).to eq(tutorial_path(tutorial3))
      expect(page).to have_content("This Tutorial does not have any videos.")
      expect(page).to have_link("Go Back")

      within(".col-4") do
        expect(page).to have_link(href: root_path)
      end
    end
  end
end
