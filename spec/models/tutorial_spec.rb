require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :thumbnail }
  it { should have_many :videos }
end
