require 'rails_helper'

describe 'visitor sees a video show' do

  it 'visitor does not see videos that have a classroom label' do
    tutorial = create(:tutorial, classroom: false)
    tutorial_2 = create(:tutorial, classroom: false)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    expect(page).to have_content(tutorial.title)
    expect(page).to have_content(tutorial_2.title)
  end
end
