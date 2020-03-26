require 'rails_helper'

describe Admin::Api::V1::TutorialSequencerController, type: :controller do
  controller do

    def update
      render :text => "update called"
    end

    def index
      render :text => "index called"
    end

  end

  it "it orders the videos in a tutorial" do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial.id)

    allow_any_instance_of(Admin::Api::V1::BaseController).to receive(:current_user).and_return(admin)
    require "pry"; binding.pry
    get :index
  end
end
