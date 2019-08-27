require 'rails_helper'

RSpec.describe Friendship do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :friend_id }
  it { should belong_to :user }
  it { should belong_to :friend }
end
