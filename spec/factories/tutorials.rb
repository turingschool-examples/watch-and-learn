# frozen_string_literal: true

# == Schema Information
#
# Table name: tutorials
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  thumbnail   :string
#  playlist_id :string
#  classroom   :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


FactoryBot.define do
  factory :tutorial do
    title { Faker::Name.unique.name }
    description { Faker::HitchhikersGuideToTheGalaxy.marvin_quote }
    thumbnail { 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg' }
    playlist_id { Faker::Crypto.md5 }
    classroom { false }
  end
end
