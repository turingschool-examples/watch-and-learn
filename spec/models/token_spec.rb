require 'rails_helper'

describe Token do
  describe 'relations' do
    it { should belong_to :user }
  end
end
