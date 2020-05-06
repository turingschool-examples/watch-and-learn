require 'rails_helper'

RSpec.describe "As a User" do
  before :each do
    json_response = File.read('spec/fixtures/github_repos.json')
    stub_request(:get, "https://api.github.com/user/repos?access_token=#{ENV['Github_token_jenny']}").
      to_return(status: 200, body: json_response)
  end
  # VCR.use_cassette('can see 5 of my repos') do
  it "I can see 5 of my repos" do
    WebMock.allow_net_connect!
    user = User.create!(email: "jennyklich@gmail.com",
                        first_name: "Jenny",
                        last_name: "Klich",
                        password: "password",
                        role: 0,
                        github_token: ENV['jenny_github_token'])
    user = User.create!(email: "kelsha@gmail.com",
                        first_name: "Kelsha",
                        last_name: "Darby",
                        password: "password",
                        role: 0,
                        github_token: ENV['kelsha_github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    expect(page).to_not have_link("monster_shop_2001", href: "https://github.com/brian-greeson/monster_shop_2001")
    expect(page).to_not have_link("b2-mid-mod", href: "https://github.com/kelshadarby/b2-mid-mod")

    within ".github" do
      expect(page).to have_link("ghost-diary-gateway", href: "https://github.com/d-atkins/ghost-diary-gateway")
      expect(page).to have_link("battleship", href: "https://github.com/iEv0lv3/battleship")
      expect(page).to have_link("adopt_dont_shop", href: "https://github.com/jklich151/adopt_dont_shop")
      expect(page).to have_link("b2-mid-mod", href: "https://github.com/jklich151/b2-mid-mod")
      expect(page).to have_link("backend_module_0_capstone", href: "https://github.com/jklich151/backend_module_0_capstone")
      expect(page).to_not have_link("best_animals")
    end
  end

  it "cannot see the github section without a token" do
    user = User.create(email: 'jennyklich@gmail.com',
                       first_name: 'Jenny',
                       last_name: 'Klich',
                       password: 'password',
                       role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    expect(page).to_not have_css(".github")
  end
end
