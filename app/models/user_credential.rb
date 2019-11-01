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

class UserCredential < ApplicationRecord
  belongs_to :user

  validates :website, :token, :nickname, presence: true
end
