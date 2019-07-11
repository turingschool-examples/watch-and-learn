# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor viewing tutorials' do
  describe 'On the home page' do
    it "shows tutorials that aren't classroom content" do
      tutorial = create(:tutorial)

      visit root_path

      within '.tutorial' do
        expect(page).to have_content(tutorial.title)
        expect(page).to have_content(tutorial.description)
      end
    end

    it "doesn't show tutorials that are classroom content" do
      tutorial = create(:tutorial, classroom: true)
      visit root_path

      expect(page).to_not have_css('.tutorial')
    end
  end
end
