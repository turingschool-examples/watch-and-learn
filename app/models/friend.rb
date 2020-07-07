class Friend < ApplicationRecord
  belongs_to :friend, class_name: 'User'
  belongs_to :friendee, class_name: 'User'
end
