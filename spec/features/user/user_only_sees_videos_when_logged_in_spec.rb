require "rails_helper"

RSpec.describe "visitor" do
  it "does not show me videos marked classroom content" do 
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

    tutorial_class_only = create(:tutorial, title: "only for the classroom", classroom: true )
    tutorial_everyone = create(:tutorial, title: "for_everyone", classroom: false)

    visit "/"

    expect(page).to have_content(tutorial_everyone.title)
    expect(page).to_not have_content(tutorial_class_only.title)
  end

  it "works for logged in users" do 
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    tutorial_class_only = create(:tutorial, title: "only for the classroom", classroom: true )
    tutorial_everyone = create(:tutorial, title: "for_everyone", classroom: false)

    visit "/"

    expect(page).to have_content(tutorial_everyone.title)
    expect(page).to have_content(tutorial_class_only.title)
  end
end
