class UserCredential < ApplicationRecord
  belongs_to :user

  validates_presence_of :token
  validates_presence_of :website
  validates_presence_of :nickname
end
