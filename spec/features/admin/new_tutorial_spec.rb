require 'rails_helper'

RSpec.describe "As an admin" do
  describe "when I visit /admin/tutorials/new, fill in all fields, and click save" do 
    before :each do 
      @admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit new_admin_tutorial_path
    end 

    it "then I should be redirected to the new tutorial's show page and see a success flash message." do 
      fill_in "Title", with: 'New Tutorial'
      fill_in "Description", with: 'Turorial description'
      fill_in "Thumbnail", with: 'https://images.template.net/wp-content/uploads/2016/04/27133811/Youtube-Thumbnail1.jpg'
      click_on "Save"

      new_tutorial = Tutorial.last

      expect(page).to have_current_path(admin_tutorial_path(new_tutorial.id))
      expect(page).to have_content("Successfully created tutorial.")
      expect(page).to have_content(new_tutorial.title)
      expect(page).to have_content(new_tutorial.description)
      expect(page).to have_css("img[src*='#{new_tutorial.thumbnail}']")
    end

    it "then I see an error flash message if one of the filled out fields is missing." do 
      fill_in "Description", with: 'Turorial description'
      fill_in "Thumbnail", with: 'https://images.template.net/wp-content/uploads/2016/04/27133811/Youtube-Thumbnail1.jpg'
      click_on "Save"

      expect(page).to have_current_path(new_admin_tutorial_path)
      expect(page).to have_content("Title can't be blank")

      visit new_admin_tutorial_path

      fill_in "Title", with: 'New Tutorial'
      fill_in "Thumbnail", with: 'https://images.template.net/wp-content/uploads/2016/04/27133811/Youtube-Thumbnail1.jpg'
      click_on "Save"

      expect(page).to have_current_path(new_admin_tutorial_path)
      expect(page).to have_content("Description can't be blank")

      fill_in "Title", with: 'New Tutorial'
      fill_in "Description", with: 'Turorial description'
      click_on "Save"

      expect(page).to have_current_path(new_admin_tutorial_path)
      expect(page).to have_content("Thumbnail can't be blank")
    end
  end 
end