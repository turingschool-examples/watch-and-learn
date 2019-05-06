require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many(:users).through :user_videos }
    it { should belong_to :tutorial}
  end

  describe 'validations' do
    it {should validate_numericality_of :position }
  end
end
