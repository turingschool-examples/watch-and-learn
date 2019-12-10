require 'rails_helper'

describe Video do
  describe 'validations' do
    it { should validate_presence_of :position }
  end
end
