require 'rails_helper'

RSpec.describe Tutorial do
  it {should have_many(:videos).dependent(:destroy)}
end
