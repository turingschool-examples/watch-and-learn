require 'rails_helper'

describe 'as visitor', :js do
  it 'brings me to the registration page when i accept an email invite' do
    VCR.use_cassette("feature/invitation_acceptance") do
      user = create(:user)
      user.github_token = ENV['GITHUB_API_KEY']
      InviteMailer.invite(user, "plapicola").deliver_now

      visit 'http://localhost:1080'

      emails = page.find_all('tr')
      within emails[1] do
        find('td', text: "Someone's Invited You!").click
      end

      within_frame(:css, '.body') do
        click_link 'here'
      end

      new_window = page.driver.browser.window_handles.last
      page.driver.browser.switch_to.window(new_window)

      expect(current_path).to eq(register_path)
    end
  end
end
