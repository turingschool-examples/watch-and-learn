# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  describe 'As a logged in user when I visit /dashboard' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    it "should have a section for 'Github'" do
      VCR.use_cassette("github/github_repositories", :allow_playback_repeats => true) do
        visit dashboard_path
        expect(page).to have_all_of_selectors(".github_section")
      end
    end
    it "shows a list of 5 repositories as links to each repository" do
      VCR.use_cassette("github/github_repositories", :allow_playback_repeats => true) do
        visit dashboard_path
        within(".github_section") do
          expect(page).to have_link("book_club")
          expect(page).to have_link("1903_final")
          expect(page).to have_link("activerecord-obstacle-course")
          expect(page).to have_link("apollo_14")
          expect(page).to have_link("backend_prework")
        end
      end
    end
  end
end
