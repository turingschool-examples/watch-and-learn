FactoryBot.define do
  factory :token do
    association :user, factory: :user

    username { "username" }
    uid { "uid" }
    provider { "provider" }
    token { "token" }

  end
end
