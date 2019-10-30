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


class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: "video_id"
  belongs_to :user, foreign_key: "user_id"
end
