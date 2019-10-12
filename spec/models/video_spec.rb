require 'rails_helper'

describe Video do
  it {should validate_numercality_of :position}
end
