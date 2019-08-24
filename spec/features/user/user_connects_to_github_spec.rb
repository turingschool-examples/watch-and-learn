require 'rails_helper'

describe 'As a user' do
  describe 'When I visit /dashboard' do
    describe 'Then I should see a link that is styled like a button that says "Connect to Github"' do
      it 'should see all of the content from the previous Github stories (repos, followers, and following)' do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        expect(page).to have_button('Connect to Github')


      end
    end
  end
end
