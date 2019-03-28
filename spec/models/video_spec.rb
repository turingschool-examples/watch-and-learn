require 'rails_helper'

RSpec.describe Video, type: :model do
  describe "Validations" do
    it {is_expected.to validate_presence_of(:position)}
  end
end
