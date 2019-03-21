require 'rails_helper'

RSpec.describe Video, type: :model do

  describe 'validations' do
    it { should validate_presence_of :position }
  end


  describe 'rake task' do
    it 'resets any videos with nil position to have default value of 0' do
      result = Video.where(position: nil)

      expect(result).to eq([])
    end
  end
end
