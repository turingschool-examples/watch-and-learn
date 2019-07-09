require "rails_helper"

describe "Add friend edge case", type: :request do
  it "shows a message if an invalid user is sent" do
		post '/friendships', { params: {friend_html: "test"}}

    expect(response).to redirect_to(dashboard_path)
		expect(flash[:message]).to be_present
  end
end
