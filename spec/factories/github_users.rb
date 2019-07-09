# frozen_string_literal: true

FactoryBot.define do
  factory :github_user do
    name { Faker::Dog.name }
    url { 'http://cdn3-www.dogtime.com' }
    uid { 5 }
  end
end
