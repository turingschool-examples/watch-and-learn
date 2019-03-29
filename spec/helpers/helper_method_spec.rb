require 'rails_helper'
describe 'calling helper methods on resource' do
  it 'returns tutorial name for a tutorial id', :vcr do
    tutorial = create(:tutorial, title: 'tutorial')
    result = ApplicationController.new.tutorial_name(tutorial.id)

    expect(result).to eq(tutorial.title)
  end

  it 'returns bookmark for bookmark id', :vcr do
    user = create(:user)
    video = create(:video)
    bookmark = UserVideo.create(user: user, video: video)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    result = ApplicationController.new.find_bookmark(bookmark.id)

    expect(result.id).to eq(bookmark.id)
  end

  # it 'updates position of videos that have nil position' do
  #   WebMock.disable!
  #   video1 = create(:video, position: nil)
  #   video2 = create(:video, position: nil)
  #
  #   result = ApplicationController.new.add_position_to_videos
  #
  #
  #   expect(Video.find(video1.id).position).to eq(0)
  #   expect(Video.find(video2.id).position).to eq(0)
  # end
end
