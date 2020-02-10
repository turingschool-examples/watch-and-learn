require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'Validations' do
    it { should_validate_presence_of :title }
    it { should_validate_presence_of :description}
    it { should_validate_presence_of :thumbnail }
  end
  describe 'Relationships' do
    it { should_have_many :videos}
  end
end
