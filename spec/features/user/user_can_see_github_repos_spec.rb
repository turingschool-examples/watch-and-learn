require 'rails_helper'

describe 'A registered user' do
  it 'can see github repos' do
    user_1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit dashboard_path

    expect(page).to_not have_content("Github")

    user_2 = create(:user)
    user_2.update(github_token: ENV["GITHUB_TOKEN_A"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)
    visit dashboard_path

    expect(page).to have_content("Github")
    expect(page).to have_link("adopt_dont_shop_2003", href: "https://github.com/#{ENV["GITHUB_USERNAME_A"]}/adopt_dont_shop_2003")
    expect(page).to have_link("ames-residential")
    expect(page).to have_link("b2-mid-mod")
    expect(page).to have_link("backend_module_0_capstone")
    expect(page).to have_link("battleship")

    user_3 = create(:user)
    user_3.update(github_token: ENV["GITHUB_TOKEN_B"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_3)
    visit dashboard_path

    expect(page).to have_content("Github")
    expect(page).to have_link("futbol")
    expect(page).to have_link("2003_classwork")
    expect(page).to have_link("activerecord-obstacle-course")
    expect(page).to have_link("adopt_dont_shop_2003", href: "https://github.com/#{ENV["GITHUB_USERNAME_B"]}/adopt_dont_shop_2003")
    expect(page).to have_link("adopt_dont_shop_paired")
    expect(page).to_not have_link("ames-residential")
    expect(page).to_not have_link("b2-mid-mod")
    expect(page).to_not have_link("backend_module_0_capstone")
    expect(page).to_not have_link("battleship")
  end
end
