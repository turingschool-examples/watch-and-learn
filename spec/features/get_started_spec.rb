require 'rails_helper'

RSpec.describe "Get started page" do
  context "as any type of user" do
    it "can see links and information on the get started page" do
      visit get_started_path

      expect(page).to have_content("Register to bookmark segments")
      expect(page).to have_link("homepage")

      within ".started-main" do
        expect(page).to have_link("Sign in")
      end
    end
  end
end
