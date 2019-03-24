module CheckUser
  extend ActiveSupport::Concern

  class_methods do
    def is_user?(github_uid)
      !(User.find_by(github_uid: github_uid).nil?)
    end
  end
end
