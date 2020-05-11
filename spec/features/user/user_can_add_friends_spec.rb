require 'rails_helper'

describe 'User' do
  it 'user can see github info' do
    user1 = User.create(email: 'user1@email.com',
      password: 'password',
      first_name:'Jim',
      role: 0,
      token: "#{ENV['GITHUB_TOKEN']}",
      username: 'Maxwell-Baird')

    user2 = User.create(email: 'user2@email.com',
      password: 'password',
      first_name:'Jim',
      role: 0,
      token: "#{ENV['GITHUB_TOKEN_2']}",
      username: 'kmcgrevey')

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user1.email
    fill_in 'session[password]', with: user1.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within("#github-followers") do
      expect(page).to have_content("alex-latham")
      expect(page).to have_content("DavidTTran")
    end

    within("#github-following") do
      expect(page).to have_content("Following")
      expect(page).to have_link("treyx")
      expect(page).to have_link("tylertomlinson")
      expect(page).to have_link("DavidTTran")
      expect(page).to have_link("kmcgrevey")
      expect(page).to have_link("Friend")
      click_on 'Friend'
    end

    within("#friends") do
      expect(page).to have_content("kmcgrevey")
    end

  end

end
