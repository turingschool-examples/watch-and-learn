require 'rails_helper'

describe "when a user is logged in and goes to their dashboard" do
  describe "shows list of all bookmarks under a header" do
    it "organizes all bookmarks by relevant tutorial and all videos by their position" do
      # As a logged in user
      user = create(:user)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      # When I visit '/dashboard'
      visit '/dashboard'

      # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
      expect(page).to have_css(".bookmarked_segments")

      # And they should be organized by which tutorial they are a part of
      # And the videos should be ordered by their position
      within ".bookmarked_segments" do
        within ".tutorial-1" do
          within "#video_1" do
            expect(page).to have_content("Prework - Environment Setup")

          end
          within "#video_2" do
            expect(page).to have_content("Prework - SSH Key Setup")
          end
        end
      end
    end
  end
end
# Only makes one query to the database (no n+1 queries)
# Avoids loading all videos into memory
