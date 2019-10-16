# Currently all tutorials are visible to anyone. We want to make tutorials marked as "classroom content" viewable only if the user is logged in.
#
# The tutorials table has a boolean column for classroom that should be used for this story.
require 'rails_helper'

describe 'Hide classroom content' do

  it 'only logged in users can see tutorials marked classroom content' do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    tutorial_1 = create(:tutorial, classroom: true, title: "class")
    tutorial_2 = create(:tutorial, classroom: false, title: "other")

    visit '/'

    expect(page).to_not have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
  end
end
