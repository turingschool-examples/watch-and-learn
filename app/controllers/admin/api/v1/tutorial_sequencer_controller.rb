# frozen_string_literal: true

<<<<<<< HEAD
module Admin
  module Api
    module V1
      # namespaced tutorial sequence controller
      class TutorialSequencerController < Admin::Api::V1::BaseController
        def update
          tutorial = Tutorial.find(params[:tutorial_id])
          TutorialSequencer.new(tutorial, ordered_video_ids).run!
          render json: tutorial
        end

        private

        def ordered_video_ids
          params[:tutorial_sequencer][:_json]
        end
      end
    end
  end
=======
class Admin::Api::V1::TutorialSequencerController < Admin::Api::V1::BaseController

>>>>>>> dbd5e46932153cdc79f6b9b4cd8abe8657de42de
end
