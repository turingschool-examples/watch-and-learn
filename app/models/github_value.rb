class GithubValue < ApplicationRecord
  belongs_to :user
  validates_presence_of :token
  validates_presence_of :uid

end
