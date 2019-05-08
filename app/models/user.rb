class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def repos
    five_repos = service.take(5)
  end

  private

    # def user_data
    #   @_user_data ||= service[:results]
    # end

    def service
      @_service ||= GithubService.new(self.id).get_repos
    end
end
