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
          user = create(:user, github_token: ENV['GITHUB_PAT'])

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit tutorial_path(tutorial)

          expect(page).to have_content(video.title)

          click_button 'Bookmark'
          visit dashboard_path

          expect(page).to have_content('Bookmarked Segments')
          within '#bookmarked-segments' do
            expect(page).to have_link('The Bunny Ears Technique')
          end
        end
      end
    end
  end
end
