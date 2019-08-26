class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def github
    tokens.where(provider: "github").take
  end
end
