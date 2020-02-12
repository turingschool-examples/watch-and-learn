require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'Validations' do
    it { should have_many :users }
    it { should have_many :user_videos }
  end
  describe 'Relationships' do
    it { should belong_to :tutorial }
  end
end 