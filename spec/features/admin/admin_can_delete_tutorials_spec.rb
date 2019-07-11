require 'rails_helper'

RSpec.describe 'As an admin on the admin' do
  describe 'on their admin dashboard' do

    it "can delete tutorials" do
      tutorial = create(:tutorial)
      admin = create(:user, role: 1)
      create(:video, tutorial: tutorial)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_link 'Destroy'

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to_not have_content(tutorial.title)
    end

  end
end
