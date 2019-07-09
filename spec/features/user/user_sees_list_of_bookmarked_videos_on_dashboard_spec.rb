# frozen_string_literal: true

require 'rails_helper'

# As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position

describe 'As a logged in user' do
  describe 'visiting their dashboard' do
    describe 'I see a list of bookmarked segments under the Bookmarked Segments section' do
      describe 'should be organized by tutorial' do
        it 'videos should be order by their position', :vcr do
          tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
          video = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
          user = create(:user)

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit tutorial_path(tutorial)

          click_on 'Bookmark'
          visit dashboard_path


          expect(page).to have_content('Bookmarked Segments')
          within '#bookmarked-segments' do
            expect(page).to have_all_of_selectors('#video-1', '#video-2', '#video-3', '#video-4', '#video-5')
          end
        end
      end
    end
  end
end
