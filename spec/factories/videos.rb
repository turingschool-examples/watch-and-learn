FactoryBot.define do
  factory :video do
    title { Faker::Games::Pokemon.name }
    description { Faker::SiliconValley.motto }
    video_id { Faker::Crypto.md5 }
    tutorial
  end
end
