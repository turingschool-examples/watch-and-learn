# frozen_string_literal: true

# == Schema Information
#
# Table name: user_credentials
#
#  id       :bigint           not null, primary key
#  website  :string
#  token    :string
#  user_id  :bigint
#  url      :string
#  nickname :string
#

FactoryBot.define do
  factory :user_credential do
    user { FactoryBot.create(:user) }
    website { "github" }
    token { Faker::Omniauth.github[:credentials][:token] }
    nickname { "TheMindSet" }
  end
end
