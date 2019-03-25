require 'rails_helper'

RSpec.describe 'Admin can delete a Tutorial' do

  describe 'As an admin' do
    describe 'when I visit my dashboard' do
      before :each do
        @admin = create(:admin)
        @tutorial_1 = create(:tutorial, title: "Tutorial 1 Title")
        @tutorial_2 = create(:tutorial, title: "Tutorial 2 title")
        @videos_from_tutorial_1 = create_list(:video, 2, tutorial: @tutorial_1)
        @videos_from_tutorial_2 = create_list(:video, 3, tutorial: @tutorial_2)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      end
      describe 'and I click on the link to delete a tutorial' do
        it 'should delete that tutorial from the database' do

          visit admin_dashboard_path

          expect(page).to have_content(@tutorial_1.title)

          within(page.all('.admin-tutorial-card')[0]) do
            click_button("Destroy")
          end

          expect(current_path).to eq(admin_dashboard_path)
          expect(Tutorial.first).to eq(@tutorial_2)
          expect(Tutorial.count).to eq(1)
          expect(page).to_not have_content(@tutorial_1.title)
          expect(page).to have_content(@tutorial_2.title)
        end

        it 'also deletes all videos under that tutorial from the database' do

          expect(Video.where(tutorial: @tutorial_1).count).to eq(2)

          visit admin_dashboard_path

          expect(page).to have_content(@tutorial_1.title)

          within(page.all('.admin-tutorial-card')[0]) do
            click_button("Destroy")
          end

          expect(Video.where(tutorial: @tutorial_1).count).to eq(0)

          expect(Video.all).to eq(@videos_from_tutorial_2)
        end

        it 'also deletes all user_videos(bookmarks) associated to that tutorial' do

          user = create(:user)

          user_video_1 = create(:user_video, user: user, video: @videos_from_tutorial_1.first )
          user_video_2 = create(:user_video, user: user, video: @videos_from_tutorial_2.first )

          visit admin_dashboard_path


          within(page.all('.admin-tutorial-card')[0]) do
            click_button("Destroy")
          end

          expect(UserVideo.where(video: @videos_from_tutorial_1.first).count).to eq(0)
          expect(UserVideo.where(video: @videos_from_tutorial_2.first).count).to eq(1)

        end
      end
    end
  end
end
