require 'rails_helper'


describe "As a regular user" do
  describe "When i visit any route under the '/admin' namespace" do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(create(:user))
    end

    it "I am given a 404 error" do
      expect { visit admin_dashboard_path }.to raise_error(ActionController::RoutingError)
    end
  end
end
