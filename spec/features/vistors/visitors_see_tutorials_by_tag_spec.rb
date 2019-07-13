require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'on the home page viewing tutorials' do

    before :each do
      @tutorial1 = create(:tutorial)
      @tutorial2 = create(:tutorial)
    end

    it "shows tutorials by tag" do
      @tutorial1.tag_list << 'dog'
      @tutorial1.save
      visit root_path

      within '.tags' do
        click_link 'dog'
      end

      expect(page).to have_css('.tutorials', count: 1)
    end

  end
end
