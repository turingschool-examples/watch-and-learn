# frozen_string_literal: true

FactoryBot.define do
  factory :tutorial do
    title { Faker::Name.unique.name }
    description { Faker::HitchhikersGuideToTheGalaxy.marvin_quote }
    thumbnail { 'https://tinyurl.com/y52leh9l' }
    playlist_id { Faker::Crypto.md5 }
    classroom { false }
  end
end
