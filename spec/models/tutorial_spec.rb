# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do

  describe 'relationships' do
    it { should have_many(:videos) }
  end

  describe 'deleting a tutorial' do
    it "deletes videos when the tutorial is deleted" do
      tutorial = Tutorial.create
      video1 = create(:video, tutorial_id: tutorial.id)

      expect { tutorial.destroy }.to change { Video.count }.by(-1)
    end
  end
end
