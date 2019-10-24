# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TutorialFacade do
  describe 'instance methods' do
    it 'can find the current video' do
      tutorial = create(:tutorial)
      create(:video, tutorial_id: tutorial.id)
      video2 = create(:video, tutorial_id: tutorial.id)
      create(:video, tutorial_id: tutorial.id)

      presenter = described_class.new(tutorial, video2.id)

      expect(presenter.current_video.id).to eq(video2.id)
    end

    it 'uses first video if video id not present' do
      tutorial = create(:tutorial)
      video1 = create(:video, tutorial_id: tutorial.id)
      create(:video, tutorial_id: tutorial.id)
      create(:video, tutorial_id: tutorial.id)

      presenter = described_class.new(tutorial)

      expect(presenter.current_video.id).to eq(video1.id)
    end

    describe "#next_video" do
      it 'can find the next video' do
        tutorial = create(:tutorial)
        video1 = create(:video, tutorial_id: tutorial.id, position: 1)
        video2 = create(:video, tutorial_id: tutorial.id, position: 2)
        create(:video, tutorial_id: tutorial.id, position: 3)

        presenter = described_class.new(tutorial, video1.id)

        expect(presenter.next_video).to eq(video2)
      end

      it "returns the last video if the current video is the last in the list" do
        learn_to_fight = create(:tutorial)
        create(:video, tutorial: learn_to_fight, position: 1)
        bloodsport = create(:video, tutorial: learn_to_fight, position: 2)

        presenter = described_class.new(learn_to_fight, bloodsport.id)
        expect(presenter.next_video).to eq(bloodsport)
      end
    end
  end
end