# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      create(:video, tutorial_id: tutorial1.id)
      create(:video, tutorial_id: tutorial1.id)
      create(:video, tutorial_id: tutorial2.id)
      create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page.has_css?('.tutorial', count: 2)).to be(true)

      within(first('.tutorials')) do
        expect(page.has_css?('.tutorial')).to be(true)
        expect(page.has_css?('.tutorial-description')).to be(true)
        expect(page.has_content?(tutorial1.title)).to be(true)
        expect(page.has_content?(tutorial1.description)).to be(true)
      end
    end
  end
end
