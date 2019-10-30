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
#  position    :integer          default(0)
#

FactoryBot.define do
  factory :video do
    title { Faker::Pokemon.name }
    description { Faker::SiliconValley.motto }
    video_id { Faker::Crypto.md5 }
    tutorial
  end
end
