require 'rails_helper'

describe "An Admin can edit a tutorial" do
  let(:tutorial) { create(:tutorial) }
  let(:admin)    { create(:admin) }

  describe 'by adding a video', :vcr do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit edit_admin_tutorial_path(tutorial)
      click_on "Add Video"
    end
    scenario "with good info" do
      fill_in "video[title]", with: "How to tie your shoes."
      fill_in "video[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
      fill_in "video[video_id]", with: "J7ikFUlkP_k"
      click_on "Create Video"

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

      within(first(".video")) do
        expect(page).to have_content("How to tie your shoes.")
      end
      expect(page).to have_content("Successfully created video.")
    end
    scenario "with bad info" do
      fill_in "video[title]", with: ""
      fill_in "video[description]", with: ""
      fill_in "video[video_id]", with: "J7ikFUlkP_k"
      click_on "Create Video"

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))
      expect(page).to have_content("Unable to create video.")
    end
  end
end
