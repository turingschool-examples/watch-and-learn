require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  it { should belong_to :user }
  it { should belong_to :video }
end
