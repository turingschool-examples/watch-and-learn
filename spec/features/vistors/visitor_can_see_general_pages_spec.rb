require "rails_helper"

context "as a visitor" do
  describe "visiting the about page" do
    it "shows information about website" do
      visit about_path
      expect(page).to have_content("Turing Tutorials")
      expect(page).to have_css(".about-main")
    end
  end

  describe "visiting the get_started page" do
    it "shows information about website" do
      visit get_started_path
      expect(page).to have_content("Get Started")
      expect(page).to have_css(".started-main")
      expect(page).to have_link("homepage")
    end
  end
end
