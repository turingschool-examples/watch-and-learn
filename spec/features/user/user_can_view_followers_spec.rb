require 'rails_helper'

RSpec.describe 'As a logged in user', type: :feature do
  describe 'if I have a github_token associated with my user' do
    before(:each) do
      @user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe 'When I visit /dashboard', :vcr do
      before(:each) do
        visit '/dashboard'
      end

        it 'Then I should see a section for "Github"' do
          expect(page).to have_css('h2', text: "Your Followers")
        end

        it 'And under that section I should see a list of all followers with the name of each follower linking to the followers profile on Github' do
          within('#followers') do
            expect(page).to have_css('li', count: 7)
            expect(page).to have_css('li:nth-of-type(6)', text: 'msimon42')
            expect(page).to have_css('li:nth-of-type(7)', text: 'rer7891')
            expect(page).to have_css('li:nth-of-type(5)', text: 'danmoran-pro')
            expect(page).to have_css('li:nth-of-type(4)', text: 'jfangonilo')
            expect(page).to have_css('li:nth-of-type(3)', text: 'aperezsantos')
            expect(page).to have_css('li:nth-of-type(2)', text: 'sasloan')
            expect(page).to have_css('li:nth-of-type(1)', text: 'PaulDebevec')
            expect(page).to have_link('msimon42', href: "https://github.com/msimon42")
            expect(page).to have_link('danmoran-pro', href: "https://github.com/danmoran-pro")
            expect(page).to have_link('jfangonilo', href: "https://github.com/jfangonilo")
            expect(page).to have_link('aperezsantos', href: "https://github.com/aperezsantos")
            expect(page).to have_link('sasloan', href: "https://github.com/sasloan")
            expect(page).to have_link('PaulDebevec', href: "https://github.com/PaulDebevec")
            expect(page).to have_link('rer7891', href: "https://github.com/rer7891")
          end
        end
      end
    end

  describe "if I don't have a github_token associated with my user" do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe 'When I visit /dashboard' do
      before(:each) do
        visit '/dashboard'
      end

      it "I see no 'Github' section and no repos listed" do
        expect(page).to_not have_css('h2', text: "Your Followers")
        expect(page).to_not have_css('#followers')
      end
    end
  end
end
