FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Creature::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
    token {ENV["GH_API_KEY"]}
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
