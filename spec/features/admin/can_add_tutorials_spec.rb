require 'rails_helper'
describe "As a logged in admin" do
  context "when I visit my 'Admin Dashboard' and click on 'New Tutorial'" do
    it "I am redirected to a page where I fill in a form, click save and am redirected to the new tutorial" do
      admin = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/tutorials/new"

      fill_in "Title", with: "How to learn in a new way"
      fill_in "Description", with: "Relearning for long term success"
      fill_in "Thumbnail", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"
      
      click_on "Save"

      tutorial = Tutorial.last
      expect(current_path).to eq("/tutorials/#{tutorial.id}")
      expect(page).to have_content(tutorial.title)
      expect(page).to have_content("Successfully created tutorial.")
    end
  end
end
