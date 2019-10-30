# frozen_string_literal: true

# == Schema Information
#
# Table name: user_credentials
#
#  id      :bigint           not null, primary key
#  website :string
#  token   :string
#  user_id :bigint
#


class UserCredential < ApplicationRecord
  belongs_to :user

end
