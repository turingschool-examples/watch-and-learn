# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe "relationships" do
    it { should belong_to :friend }
  end
end
