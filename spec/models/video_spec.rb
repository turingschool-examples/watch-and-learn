# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  video_id    :string
#  thumbnail   :string
#  tutorial_id :bigint
#  position    :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe Video, type: :model do
  it "has a valid factory" do
    expect(build(:video)).to be_valid
  end

  describe "Associations" do
    let(:klass) { build(:klass) }

    it { is_expected.to belong_to(:tutorial) }
    it { is_expected.to have_many(:user_videos) }
    it { is_expected.to have_many(:users).through(:user_videos) }
  end

  describe "Validation" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:video_id) }
    it { is_expected.to validate_presence_of(:position) }
  end
end
