require 'rails_helper'

describe 'User' do
  include Capybara::DSL

  it 'user can see github info' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      extra: {
        raw_info: {
          uid: "1234",
          name: "Horace",
          login: "Maxwell-Baird",
        }
      },
      credentials: {
        token: "#{ENV['GITHUB_TOKEN']}",
        secret: "secretpizza"
      }
    })

    user = User.create(email: 'user@email.com',
      password: 'password',
      first_name:'Jim',
      role: 0)

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'
    expect(page).to have_no_content("Maxwell-Baird/adopt_dont_shop_paired")
    expect(page).to have_no_content("Maxwell-Baird/b2-mid-mod")
    expect(page).to have_no_content("Maxwell-Baird/backend_module_0_capstone")
    expect(page).to have_no_content("Maxwell-Baird/battleship")
    expect(page).to have_no_content("Maxwell-Baird/black_thursday_lite")
    expect(page).to have_no_link("treyx")
    expect(page).to have_no_link("tylertomlinson")
    expect(page).to have_no_link("DavidTTran")
    expect(page).to have_no_content("alex-latham")
    expect(page).to have_no_content("DavidTTran")

    click_on 'Connect to Github'

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
