require 'rails_helper'

describe 'visitor visits video show page' do
  it 'Cannot see tutorials labeled classroom content' do
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial, description: "Amazing Much Learning!", classroom: true)

      # video1 = create(:video, tutorial_id: tutorial1.id)
      # video2 = create(:video, tutorial_id: tutorial1.id)
      # video3 = create(:video, tutorial_id: tutorial2.id)
      # video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      within(first('.tutorials')) do
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)

        expect(page).to_not have_content(tutorial2.title)
        expect(page).to_not have_content(tutorial2.description)
    end
  end
end 
# Currently all tutorials are visible to anyone.
# We want to make tutorials marked as "classroom content" viewable
# only if the user is logged in.
#
# The tutorials table has a boolean column for
# classroom that should be used for this story.
