require 'rails_helper'

describe 'visitor visits tutorial index page' do
  xit 'clicks on the classroom content and is sent to the log in page' do
    tutorial = create(:tutorial, classroom: true)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorials_path

    click_on 'Bookmark'

    expect(current_path).to eq(login_path)
  end
end
