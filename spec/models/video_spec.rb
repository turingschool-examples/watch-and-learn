require 'rails_helper'

describe Video do
  describe 'validations' do
    it { should validate_presence_of :position }
  end

  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many(:users).through(:user_videos) }
    it { should belong_to :tutorial }
  end
end
