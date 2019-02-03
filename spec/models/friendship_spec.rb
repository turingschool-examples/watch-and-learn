require 'rails_helper'

describe Friendship do
  describe 'relationships' do
    it { should belong_to(:user) }
  end
end
