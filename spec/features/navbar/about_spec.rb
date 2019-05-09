require 'rails_helper'

describe  'About Tab - Navbar' do
  context 'as any user on any webpage' do
    it 'shows an about link which takes me to an about page' do

      visit root_path

      expect(page).to have_css(".primary_nav")

      click_link("About")

      expect(current_path).to eq(about_path)

      expect(page).to have_css(".primary_nav")
      expect(page).to have_link("About")
    end
  end
end
