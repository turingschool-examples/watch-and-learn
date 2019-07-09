require 'rails_helper'

RSpec.describe Video, type: :model do

  describe 'validations' do
    it { should validate_presence_of :position }
  end

  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many :users }
    it { should belong_to :tutorial }
  end
end
