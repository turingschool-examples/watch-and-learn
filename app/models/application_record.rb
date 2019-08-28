class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def github_credentials
    tokens.where(provider: "github").take
  end
end
