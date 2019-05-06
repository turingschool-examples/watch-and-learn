FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
    token {"8e08129aa359391e0f54b1192be5a9c3bb819e09"}
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
