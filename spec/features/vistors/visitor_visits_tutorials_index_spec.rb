require 'rails_helper'

describe 'Visitor' do
  describe 'on the tutorial index page' do
    before :each do
      @tutorials = create_list(:tutorial, 3)
    end

    it 'sees a list of tutorials' do
      visit tutorials_path

      expect(page).to have_css(".tutorial", count: 3)
      within(page.find_all(".tutorial").first) do
        expect(page).to have_link @tutorials.first.title
        expect(page).to have_content @tutorials.first.description
      end
    end

    it 'sees only non-classroom content' do
      classroom_tutorial = create(:classroom_tutorial,
                                  title: "Unique!",
                                  description: "Also Unique")

      visit tutorials_path

      expect(page).to have_css(".tutorial", count: 3)
      expect(page).to_not have_link classroom_tutorial.title
      expect(page).to_not have_content classroom_tutorial.description
    end
  end
end
