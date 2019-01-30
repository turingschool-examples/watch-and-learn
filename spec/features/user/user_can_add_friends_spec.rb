require 'rails_helper'

describe 'as a logged in user' do
  it 'sees add friend link next to followers and following' do
    binding.pry
    user = create(:user, token: ENV["GITHUB_API_KEY"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within(".github") do
      within(all(".follower").first) do
        click_on "Add as Friend"
        expect(current_path).to eq('/dashboard')
        expect(page).to have_no_content("Add as Friend")
      end
    end

    within(".github") do
      within(all(".following").first) do
        click_on "Add as Friend"
        expect(current_path).to eq('/dashboard')
        expect(page).to have_no_content("Add as Friend")
      end
    end
  end
end