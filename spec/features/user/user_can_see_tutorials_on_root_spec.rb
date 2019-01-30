require 'rails_helper'

describe 'user sees all tutorials' do
  it 'user can see all tutorials' do
    tutorial = create(:tutorial, classroom: false)
    tutorial_2 = create(:tutorial, classroom: true)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    expect(page).to have_content(tutorial.title)
    expect(page).to have_content(tutorial_2.title)
  end
end
