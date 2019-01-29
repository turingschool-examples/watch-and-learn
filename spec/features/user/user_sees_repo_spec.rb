require 'rails_helper'

describe "User Nav" do
  it "it can see section for GitHub" do
    user = create(:user)
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
