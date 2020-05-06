require 'rails_helper'

describe 'User' do
  before :each do
    @user = create(:user)
    @user2 = create(:user)
    visit '/'
    click_on "Sign In"
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_on 'Log In'
  end

  it "once logged in, cannot see repositories if missing token" do
    visit '/dashboard'

    expect(page).to have_no_content("Github")

    expect(page).to_not have_link("futbol")
    expect(page).to_not have_link("brownfield-of-dreams")
    expect(page).to_not have_link("alpha_paradigms_academy")
    expect(page).to_not have_link("metaphysics")
    expect(page).to_not have_link("metaphysics-dev")
  end

  it "once logged in, can see their repositories if they have a token" do
    @user.update(token: ENV['GITHUB_TOKEN_1'])
    # @user2.update(token: ENV['GITHUB_TOKEN_2'])

    visit '/dashboard'

    expect(page).to have_link("futbol")
    expect(page).to have_css('a[href="https://github.com/iEv0lv3/futbol"]')

    expect(page).to have_link("brownfield-of-dreams")
    expect(page).to have_css('a[href="https://github.com/javier-aguilar/brownfield-of-dreams"]')

    expect(page).to have_link("alpha_paradigms_academy")
    expect(page).to have_css('a[href="https://github.com/quiet-storm/alpha_paradigms_academy"]')

    expect(page).to have_link("metaphysics")
    expect(page).to have_css('a[href="https://github.com/quiet-storm/metaphysics"]')

    expect(page).to have_link("metaphysics-dev")
    expect(page).to have_css('a[href="https://github.com/quiet-storm/metaphysics-dev"]')
  end
end
