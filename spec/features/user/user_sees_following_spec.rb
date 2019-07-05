# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it "user goes to dashboard and sees links to the accounts they're following" do
    VCR.use_cassette("features/user/user_sees_following") do
      user = create(:user)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'

      within '.github' do
        within '.following' do
          expect(page).to have_css("#following-1")
        end
      end

      within '#following-1' do
        expect(page).to have_link("ryanmillergm", href: "https://github.com/ryanmillergm")
      end
    end
  end

  xit 'user goes to dashboard and sees message for no followers' do
  #   VCR.use_cassette("features/user/user_sees_followers") do
  #     user = create(:user)
  #
  #     visit '/'
  #
  #     click_on 'Sign In'
  #
  #     expect(current_path).to eq(login_path)
  #
  #     fill_in 'session[email]', with: user.email
  #     fill_in 'session[password]', with: user.password
  #
  #     click_on 'Log In'
  #
  #     visit '/dashboard'
  #
  #     within '.github' do
  #       within '.followers' do
  #         expect(page).to have_css("#follower-1")
  #       end
  #     end
  #
  #     within '#follower-1' do
  #       expect(page).to have_link("ryanmillergm", href: "https://github.com/ryanmillergm")
  #     end
  #   end
  end
end
