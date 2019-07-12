# frozen_string_literal: true

require 'rails_helper'
describe TutorialFacade do
  context '#next_video' do
    it 'can find the next video' do
      tutorial = create(:tutorial)
      video1 = create(:video, tutorial_id: tutorial.id, position: 1)
      video2 = create(:video, tutorial_id: tutorial.id, position: 2)
      create(:video, tutorial_id: tutorial.id, position: 3)

      presenter = TutorialFacade.new(tutorial, video1.id)

      expect(presenter.next_video).to eq(video2)
    end

    it 'returns the last video if current video is the last in the list' do
      learn_to_fight = create(:tutorial)
      create(:video, tutorial: learn_to_fight, position: 1)
      bloodsport = create(:video, tutorial: learn_to_fight, position: 2)

      presenter = TutorialFacade.new(learn_to_fight, bloodsport.id)
      expect(presenter.next_video).to eq(bloodsport)
    end
  end
end
