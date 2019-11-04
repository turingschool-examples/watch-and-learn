require 'rails_helper'

RSpec.describe Video, type: :model do
  it "has a valid factory" do
    expect(build(:video)).to be_valid
  end


  describe "Associations" do
    let(:klass) { build(:klass) }

    it { is_expected.to belong_to(:tutorial) }
    it { should have_many(:user_videos) }
    it { should have_many(:users).through(:user_videos) }

  end

  describe "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:video_id) }
    it { should validate_presence_of(:position) }
  end

end
