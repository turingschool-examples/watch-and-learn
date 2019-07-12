# frozen_string_literal: true

require 'rails_helper'
describe TutorialFacade do
  context '#current_video' do
    it 'can find the current video' do
      tutorial = create(:tutorial)
      create(:video, tutorial_id: tutorial.id)
      video2 = create(:video, tutorial_id: tutorial.id)
      create(:video, tutorial_id: tutorial.id)

      presenter = TutorialFacade.new(tutorial, video2.id)

      expect(presenter.current_video.id).to eq(video2.id)
    end

    it 'uses first video if video id not present' do
      tutorial = create(:tutorial)
      video1 = create(:video, tutorial_id: tutorial.id)
      create(:video, tutorial_id: tutorial.id)
      create(:video, tutorial_id: tutorial.id)

      presenter = TutorialFacade.new(tutorial)

      expect(presenter.current_video.id).to eq(video1.id)
    end
  end
end
