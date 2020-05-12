require 'rails_helper'

describe 'User' do
  it 'user can see github info', :vcr do
    user = User.create(email: 'user@email.com',
      password: 'password',
      first_name:'Jim',
      role: 0,
      token: "#{ENV['GITHUB_TOKEN']}")

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within("#github-repos") do
      expect(page).to have_content("Maxwell-Baird/adopt_dont_shop_paired")
      expect(page).to have_content("Maxwell-Baird/b2-mid-mod")
      expect(page).to have_content("Maxwell-Baird/backend_module_0_capstone")
      expect(page).to have_content("Maxwell-Baird/battleship")
      expect(page).to have_content("Maxwell-Baird/black_thursday_lite")
    end

    within("#github-followers") do
      expect(page).to have_content("alex-latham")
      expect(page).to have_content("DavidTTran")
    end
    
    within("#github-following") do
      expect(page).to have_content("Following")
      expect(page).to have_link("treyx")
      expect(page).to have_link("tylertomlinson")
      expect(page).to have_link("DavidTTran")
    end

  end

end
