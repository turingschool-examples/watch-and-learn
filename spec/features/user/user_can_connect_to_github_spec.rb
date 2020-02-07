require 'rails_helper'

describe "As a User, when I visit my dashboard" do
  context "I see a button to 'Connect to Github'" do
    it "I go through the OAuth process, am redirected to my dashboard, and see My Github Section" do
      user = create(:user)
    end
  end
end
