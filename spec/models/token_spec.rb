require "rails_helper"
describe Token, type: :model do
  describe "relationships" do
    it {should belong_to :user}
  end
end
