require "rails_helper"

describe "Add friend edge case" do
  it "shows a message if an invalid user is sent" do
    post(friendships_path, { params: {friend_html: "test"}})
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Invalid Friend.")
  end
end
