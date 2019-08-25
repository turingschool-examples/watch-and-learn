require 'rails_helper'

RSpec.describe UserCredential, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:token)}
    it {should validate_presence_of(:website)}
    it {should validate_presence_of(:nickname)}
  end

	describe 'relationships' do
		it {should belong_to :user}
	end
end
