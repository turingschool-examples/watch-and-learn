require 'rails_helper'

describe "Registered User Profile Dashboard" do
  before :each do 
    @user = create(:user, role: "default")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  
  it "5 Github repositories are listed as links" do
    visit dashboard_path 
   
    expect(page).to have_content("Github")

    within(".github")do
    expect(page).to have_link("battleship")
    expect(page).to have_link("monster_shop_2003")
    expect(page).to have_link("adopt_dont_shop_2003_paired")
    expect(page).to have_link("activerecord-obstacle-course")
    # expect(page).to have_link(href: "https://github.com/", count: 5)
    expect(page).to have_css(".github_link", count: 5)
    # click_link("adopt_dont_shop_2003")
    end
    # expect(current_path).to eq("https://github.com/perryr16/adopt_dont_shop_2003")
    
  end
  
end