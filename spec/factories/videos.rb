# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    title { Faker::Creature::Dog.name }
    description { Faker::Creature::Dog.meme_phrase }
    video_id { Faker::Crypto.md5 }
    tutorial
  end
end
