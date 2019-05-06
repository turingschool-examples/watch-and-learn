FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
    token {"da3d518e0f32fc4e3671a8b9457bd0e5a192f58d"}
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
