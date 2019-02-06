require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it "class exits" do
    inviation = Invitation.new
    expect(inviation).to be_a(Invitation)
  end
end
