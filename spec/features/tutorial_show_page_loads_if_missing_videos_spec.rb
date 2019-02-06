require 'rails_helper'

describe "As a user" do
  describe "When I visit a tutorial without any videos" do
    it "It loads without crashing" do
      tutorial = create(:tutorial)

      expect {visit tutorial_path(tutorial)}.to_not raise_error
    end
  end
end
