require 'rails_helper'

RSpec.describe Video do
  it {should belong_to :tutorial}
  it {should have_many(:users).through(:user_videos)}
  it {should have_many(:user_videos).dependent(:destroy)}
end
