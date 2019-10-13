# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    title { Faker::Pokemon.name }
    description { Faker::Creature::Dog.meme_phrase }
    video_id { Faker::Crypto.md5 }
    tutorial
  end
end
