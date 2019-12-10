require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :video }
  end
end
