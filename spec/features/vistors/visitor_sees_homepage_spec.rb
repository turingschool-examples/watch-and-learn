require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end
    end

    it 'cannot see tutorials listed as class content' do
      tutorial1 = create(:tutorial, classroom: true)
      tutorial2 = create(:tutorial, classroom: true)
      tutorial3 = create(:tutorial)
      tutorial4 = create(:tutorial)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial3.title)
        expect(page).to have_content(tutorial3.description)
      end
    end
  end

  it 'can click on tags' do
    tutorial1 = create(:tutorial, classroom: true)
    tutorial2 = create(:tutorial, classroom: true)
    tutorial3 = create(:tutorial)
    tutorial4 = create(:tutorial)
    tag = ActsAsTaggableOn::Tag.create!(name: "Bongo", taggings_count: 3 )
    tutorial4.tags << tag
    tutorial1.tags << tag
    visit root_path
    click_on "Bongo"
    expect(page).to have_content(tutorial4.title)
    expect(page).to have_content(tutorial4.description)
    expect(page).to_not have_content(tutorial1.title)
    expect(page).to_not have_content(tutorial2.title)
    expect(page).to_not have_content(tutorial3.title)
  end
end
