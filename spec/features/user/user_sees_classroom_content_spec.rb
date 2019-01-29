require 'rails_helper'

describe 'User' do
  xit "can see classroom content when logged in" do
    user = create(:user)
    tutorial = create(:tutorial, classroom: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(:current_user)

    visit

    expect(page).to have_content(tutorial)
  end

end
