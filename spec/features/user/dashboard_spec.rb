require 'rails_helper'

describe "A registered user" do
  it 'can visit dashboard and does not see GitHub repos without token' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_no_content("GitHub")
  end

  it 'can visit dashboard and see GitHub repos' do
    user = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        git_hub_token: "297f3266de9167cd907402888af4721c431bb1dc"})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within('#repos') do
      expect(page).to have_content("GitHub")
      expect(page).to have_content("brownfield-of-dreams")
      # click_link("neos")
    end

    # expect(current_path).to eq("https://github.com/DavidTTran/neos")
  end

  it "users only see repos associated with their unique token" do
    user = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        git_hub_token: "297f3266de9167cd907402888af4721c431bb1dc"})
  end

  it 'user with token can visit dashboard and see followers' do
    user = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        git_hub_token: "297f3266de9167cd907402888af4721c431bb1dc"})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within("#followers") do
      expect(page).to have_content("Followers")
      expect(page).to have_link("SMJ289")
      # click_link 'SMJ289'
    end

    # expect(current_path).to eq("https://github.com/SMJ289")
  end
end
