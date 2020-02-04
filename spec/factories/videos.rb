require 'faker'

FactoryBot.define do
  factory :video do
    title { Faker::Games::Pokemon.name }
    description { Faker::TvShows::SiliconValley.motto }
    video_id { Faker::Crypto.md5 }
    tutorial
  end
end
