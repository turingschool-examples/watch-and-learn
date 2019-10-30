# frozen_string_literal: true

# == Schema Information
#
# Table name: user_videos
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  video_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :user_video do
  end
end
