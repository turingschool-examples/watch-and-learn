class GithubValue < ApplicationRecord
  belongs_to :user
  validates_presence_of :token
  validates_presence_of :uid
  validates_presence_of :handle

  def correlated?(handle)
    GithubValue.find_by(handle: handle)
  end
end
