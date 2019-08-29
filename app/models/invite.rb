class Invite
   include ActiveModel::Model
#   #This apparently makes the model quack like an ActiveRecord model without being backed by a database table.
  attr_reader :login, :email, :message
#
end
