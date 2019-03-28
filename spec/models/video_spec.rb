require 'rails_helper'

RSpec.describe "Video", type: :model do
  describe "Validations" do
    it {should validate_presence_of(:position)}
  end

  it "Video doesn't save without position" do
    video = Video.create(position: nil)

    expect(video).to be(nil)
  end
end
