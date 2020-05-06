require 'rails_helper'

describe "A registered user" do
  it 'can visit dashboard and does not see GitHub repos without token' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_no_content("GitHub")
  end

  it 'can visit dashboard and see GitHub repos', :js do
    user = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        git_hub_token: ENV['GH_TEST_KEY_1']})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within('#repos') do
      expect(page).to have_content("GitHub")
      expect(page).to have_link("brownfield-of-dreams")
      expect(page).to have_link("neos")
      click_link("brownfield-of-dreams")
    end

    expect(current_url).to eq("https://github.com/jrsewell400/brownfield-of-dreams")
  end

  it "users only see repos associated with their unique token" do
    user1 = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        git_hub_token: ENV['GH_TEST_KEY_1']})

    user2 = User.create({email: "example@example.com",
                        first_name: "Jordan",
                        last_name: "Sewell",
                        password: "password",
                        role: "default",
                        git_hub_token: ENV['GH_TEST_KEY_2']})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit dashboard_path

    expect(page).to have_content("test-repo")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit dashboard_path

    expect(page).to have_no_content("test-repo")
  end

  it 'user with token can visit dashboard and see followers', :js do
    user = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        git_hub_token: ENV['GH_TEST_KEY_1']})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within("#followers") do
      expect(page).to have_content("Followers")
      expect(page).to have_link("SMJ289")
      click_link 'SMJ289'
    end

    expect(current_url).to eq("https://github.com/SMJ289")
  end

  it 'user with token can visit dashboard and see following', :js do
    user = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        git_hub_token: ENV['GH_TEST_KEY_1']})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within("#following") do
      expect(page).to have_content("Following")
      expect(page).to have_link("SMJ289")
      click_link 'SMJ289'
    end

    expect(current_url).to eq("https://github.com/SMJ289")
  end
end
