require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it "class exits" do
    inviation = Invitation.new
    expect(inviation).to be_a(Invitation)
  end
  describe "validations" do
    it { should validate_presence_of :invitee_email }
  end
end
