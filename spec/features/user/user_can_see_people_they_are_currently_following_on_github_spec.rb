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
          expect(page).to have_css('h2', text: "Following")
        end

        it 'And under that section I should see a list of all accounts I am following with the name of each followee linking to the followees profile on Github' do
          within('#following') do
            expect(page).to have_css('li', count: 3)
            expect(page).to have_css('li:nth-of-type(2)', text: 'msimon42')
            expect(page).to have_css('li:nth-of-type(1)', text: 'ganelson')
            expect(page).to have_css('li:nth-of-type(3)', text: 'jfangonilo')
            expect(page).to have_link('msimon42', href: "https://github.com/msimon42")
            expect(page).to have_link('jfangonilo', href: "https://github.com/jfangonilo")
            expect(page).to have_link('ganelson', href: "https://github.com/ganelson")
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
        expect(page).to_not have_css('h2', text: "Following")
        expect(page).to_not have_css('#following')
      end
    end
  end
end
