require 'rails_helper'

describe 'An admin user can add tags to tutorials' do
  scenario 'create tutorial' do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

	VCR.turned_off do
	WebMock.allow_net_connect!
    visit "/admin/dashboard"
	click_on "New Tutorial"

	fill_in 'tutorial[title]', with: "test"
	fill_in 'tutorial[description]', with: "test description"
	fill_in 'tutorial[thumbnail]', with: "https://upload.wikimedia.org/wikipedia/commons/b/b4/Logan_Rock_Treen_closeup.jpg"
	click_on "Save"

	expect(Tutorial.last.title).to eq("test")
	expect(Tutorial.last.description).to eq("test description")
	end
   end

   scenario 'tutorial sad path' do
	
	admin = create(:user, role: 1)
        tutorial = create(:tutorial)
        video1 = create(:video, tutorial_id: tutorial.id)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
	
	VCR.turned_off do
	WebMock.allow_net_connect!

	visit "/admin/dashboard"
        click_on "New Tutorial"

        fill_in 'tutorial[thumbnail]', with: "https://upload.wikimedia.org/wikipedia/commons/b/b4/Logan_Rock_Treen_closeup.jpg"
        click_on "Save"
	expect(page).to have_content("Title can't be blank and Description can't be blank")
	fill_in 'tutorial[title]', with: "test"
        fill_in 'tutorial[description]', with: "test description"
        fill_in 'tutorial[thumbnail]', with: "-2fonqoiur.fjwoaiepgba"
        click_on "Save"
	expect(page).to have_content("link needs to be to an image")	
	end
   end
end
