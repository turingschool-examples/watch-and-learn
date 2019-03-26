FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
    email_confirmed { true }
  end

  factory :admin, parent: :user do
    role { :admin }
  end

  factory :friend_user, parent: :user do
    first_name { "Friend" }
  end
end
