# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :friend_user_id }
  end
end
