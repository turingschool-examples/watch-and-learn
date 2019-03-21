require 'rails_helper'

describe 'As an admin' do
  describe 'I can add new tutorials from my admin dashboard' do
    before :each do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    
    it 'when providing valid information' do
      visit new_admin_tutorial_path

      fill_in :title, with: "I'm a test"
      fill_in :descroption, with: "I'm a description for a test"
      fill_in :thumbnail, with: "https://fakecompany.no/thisisathumbnail.png"

      expect(current_path).to eq(tutorial_path(Tutorial.last))
      expect(page).to have_content "Successfully created \"I'm a test\"."
      expect(Tutorial.last.title).to eq("I'm a test")
    end

    it 'If I provide incorrect information I see a flash message indicating the error' do
      visit new_admin_tutorial_path

      click_button 'Save'

      expect(page).to have_content("Title cannot be blank")
      expect(page).to have_content("Thumbnail cannot be blank")
      expect(page).to have_content("Description cannot be blank")
    end
  end
end
