require 'rails_helper'

context 'On a tutorial show page with no videos' do
  before :each do
    @tutorial = create(:tutorial)
  end
  context 'as a user or visitor' do
    it 'shows an apology message' do
      message = "Sorry, no videos added yet!"

      visit tutorial_path(@tutorial)
      expect(page).to_not have_css('.video')
      expect(page).to have_content(message)
      expect(page).to_not have_link('Add Video to Tutorial')
    end
  end

  context 'as an admin' do
    it 'shows an add video button' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit tutorial_path(@tutorial)
      expect(page).to_not have_css('.video')
      click_link('Add Video to Tutorial')
      expect(current_path).to eq(edit_admin_tutorial_path(@tutorial))
    end
  end
end
