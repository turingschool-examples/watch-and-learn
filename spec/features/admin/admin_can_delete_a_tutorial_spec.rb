require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit my admin dashboard I see a link to delete a tutorial' do
    before :each do
      @admin = create(:admin)
      @tutorial = create(:tutorial)
      @other_tutorial = create(:tutorial)
      @tutorial_videos = create_list(:video, 3, tutorial: @tutorial)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it 'removes the tutorial from the system' do
      visit admin_dashboard_path

      tutorials = page.find_all('.admin-tutorial-card')

      within tutorials[0] do
        click_link 'Destroy'
      end

      expect(current_path).to eq(admin_dashboard_path)
      expect(Tutorial.count).to eq(1)
      expect(page).to_not have_content(@tutorial.name)
    end

    it 'removes the videos for the tutorial from the system' do
      other_video = create(:video, tutorial: @other_tutorial)
      visit admin_dashboard_path

      tutorials = page.find_all('.admin-tutorial-card')

      within tutorials[0] do
        click_link 'Destroy'
      end

      expect(Video.count).to eq(1)
      expect(Video.all).to eq([other_video])
    end

    it 'removes the bookmarks for videos for the tutorial from the system' do
      other_video = create(:video, tutorial: @other_tutorial)
      user_video = create(:user_video, video: @tutorial_videos.first)
      other_user_video = create(:user_video, video: other_video)
      visit admin_dashboard_path

      tutorials = page.find_all('.admin-tutorial-card')

      within tutorials[0] do
        click_link 'Destroy'
      end

      expect(UserVideo.count).to eq(1)
      expect(UserVideo.all).to eq([other_user_video])
    end
  end
end
