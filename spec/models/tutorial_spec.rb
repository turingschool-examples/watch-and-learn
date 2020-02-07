require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'relationships' do
    it {should have_many :videos}
  end
end
