require 'rails_helper'

describe Video do
  it {should validate_numericality_of :position}
end
