require 'rails_helper'

RSpec.describe "As an admin user" do
  describe "when I visit my admin dashboard" do
    it "I see a link 'Import YouTube Playlist' that takes me to a form to add a playlist" do 
      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'

      click_link "Import Youtube Playlist"

      fill_in :playlist_id, with: "PL7hyQeCP1V6SLJOBVgh5gVnHwBFyEqF6a"
           
      click_on "Import Playlist"
      tutorial = Tutorial.last

      expect(current_path).to eq("/admin/dashboard")
      expect(page).to have_content("Successfully created tutorial. To view click here")
      expect(page).to have_link("#{tutorial.title}")

      click_link "#{tutorial.title}"
      
      expect(current_path).to eq("/tutorials/#{tutorial.id}")
     
      expect(page).to have_css('.show-link', count: 14)
      
    end
  end
  # describe "when I visit my tutorials new page" do
  #   it "I can fill in the fields and create a new tutorial" do
  #     admin = create(:user, role: 1)
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

  #     visit '/admin/tutorials/new'

  #     fill_in :tutorial_title, with: "Learn Ruby on Rails"
  #     fill_in :tutorial_description, with: "This is the perfect tutorial for a rookie programmer that wants to learn Ruby on Rails"
  #     fill_in :tutorial_thumbnail, with: "https://i.ytimg.com/vi/UT4W6jAyO_o/default.jpg"

  #     click_button "Save"
  #     tutorial = Tutorial.last 
     
  #     expect(current_path).to eq("/tutorials/#{tutorial.id}")
  #   end
  # end
end

# When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."