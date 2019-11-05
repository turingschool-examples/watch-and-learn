# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  role            :integer          default("default")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  activate        :boolean          default(FALSE)
#

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
