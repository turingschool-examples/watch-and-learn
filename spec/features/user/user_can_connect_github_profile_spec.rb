require 'rails_helper'

describe 'Github Oauth' do
  context 'on user dashboard' do
    it "shows button to connect account" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      expect(page).to have_link("Connect to Github")
    end
    context "when clicking 'Connect to Github'" do
      before :each do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit dashboard_path
        click_link "Connect to Github"
      end
      it 'goes through Oauth process and redirects back' do
        expect(current_path).to eq(dashboard_path)
      end
      xit 'shows content from Github profile' do

      end
    end
  end
end
