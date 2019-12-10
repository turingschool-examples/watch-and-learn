require 'rails_helper'

describe 'an admin user can add a new tutorial' do
  it 'and sees a flash message saying the tutorial was added' do
    admin = create(:user, role: 1)
    tutorial_1 = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    fill_in 'tutorial[title]', with: 'How to restring a banjo'
    fill_in 'tutorial[description]', with: 'This is a series of 90 minute videos on how to change the strings on the greatest instrument ever - the banjo.'
    fill_in 'tutorial[thumbnail]', with: 'http://i3.ytimg.com/vi/7VMyKo7DOs0/maxresdefault.jpg'

    click_on 'Save'

    tutorial_2 = Tutorial.last

    expect(current_path).to eq("/tutorials/#{tutorial_2.id}")
    expect(page).to have_content('Successfully created tutorial.')
  end
end

describe 'an admin user cannot add an incomplete tutorial' do
  it 'and sees a flash message saying the tutorial failed to be added' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    fill_in 'tutorial[title]', with: ''
    fill_in 'tutorial[description]', with: 'This is a series of 90 minute videos on how to change the strings on the greatest instrument ever - the banjo.'
    fill_in 'tutorial[thumbnail]', with: 'http://i3.ytimg.com/vi/7VMyKo7DOs0/maxresdefault.jpg'

    click_on 'Save'

    expect(page).to have_content("Title can't be blank")
  end
end