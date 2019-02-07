require 'rails_helper'

describe "Admin can create new tutorial" do
  it "fills in form and should see new tutorial" do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    title = "Lets Read"
    description = "Scary Stories for your listening pleasure"
    thumbnail = "https://yt3.ggpht.com/a-/AAuE7mBWla053ZenbwKZ3eBdEMFa96mr2OxiLM-_9w=s900-mo-c-c0xffffffff-rj-k-no"

    visit "admin/tutorials/new"

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in "tutorial[title]", with: title
    fill_in "tutorial[description]", with: description
    fill_in "tutorial[thumbnail]", with: thumbnail
    click_on "Save"

    expect(current_path).to eq("/admin/tutorials/#{Tutorial.last.id}")
    expect(page).to have_content("Successfully created tutorial")
  end

end
