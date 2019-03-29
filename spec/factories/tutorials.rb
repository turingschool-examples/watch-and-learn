# frozen_string_literal: true

FactoryBot.define do
  factory :tutorial do
    title { Faker::Name.unique.name }
    description { Faker::HitchhikersGuideToTheGalaxy.marvin_quote }
    # rubocop:disable Metrics/LineLength
    thumbnail { 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg' }
    # rubocop:enable Metrics/LineLength
    playlist_id { Faker::Crypto.md5 }
    classroom { false }
  end
end
