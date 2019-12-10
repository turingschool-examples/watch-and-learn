require 'rails_helper'

describe 'Admin dashboard page' do
  describe 'As an admin' do
    it 'can delete videos when deleting tutorials' do
      tutorial = create(:tutorial)
      video_1 = create(:video, tutorial_id: tutorial.id)
      video_2 = create(:video, tutorial_id: tutorial.id)

      tutorial_2 = create(:tutorial)
      video_3 = create(:video, tutorial_id: tutorial_2.id)
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      within "##{tutorial.id}" do
        click_button "Destroy"
      end

      expect{Video.find(video_1.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect{Video.find(video_2.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(Video.find(video_3.id)).to eq(video_3)
    end
  end
end
