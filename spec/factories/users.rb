FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
    verified { true }
  end

  factory :admin, parent: :user do
    role { :admin }
  end

  factory :non_validated_user, parent: :user do
    verified { false }
  end

  factory :github_user, parent: :user do
    github_token { ENV['GITHUB_API_KEY']}
    sequence :uid { |n| n }
  end
end
