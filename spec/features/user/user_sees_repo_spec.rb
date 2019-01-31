require 'rails_helper'

describe "User Nav" do
  it "it can see section for GitHub" do
    VCR.use_cassette "github token key test" do
      user = create(:user, token: ENV["GITHUB_API_KEY"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/dashboard"

      expect(page).to have_content("Github")
      within(".github") do
        expect(all(".repo").length).to eq(5)
      end
      within(first(".github")) do
        expect(page).to have_css(".name")
      end
    end
  end
  it "it sees no GitHub without token" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    expect(page).to have_no_css(".github")
  end
end
