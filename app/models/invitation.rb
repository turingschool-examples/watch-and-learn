class Invitation < ApplicationRecord
  validates_presence_of :invitee_email
end
