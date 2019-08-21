FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
    github_token { '1c5295f20b6d943b24001b132be270c182c55e26'}
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
