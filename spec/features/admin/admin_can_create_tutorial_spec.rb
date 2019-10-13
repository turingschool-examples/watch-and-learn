require 'rails_helper'

describe 'Admin tutorials' do
  before :each do
    @admin = create(:admin)
    @title = 'Test Creation'
    @description = 'This is not a real tutorial'
    @thumbnail = 'https://cosmolearning.org/images_dir/courses/713/profile-thumbnail-w300.jpg'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit '/admin/tutorials/new'
  end
  it 'Admin can create new tutorials' do
    fill_in 'Title', with: @title
    fill_in 'Description', with: @description
    fill_in 'Thumbnail', with: @thumbnail

    click_on 'Save'

    new_tutorial = Tutorial.last

    expect(current_path).to eq("/tutorials/#{new_tutorial.id}")

    expect(page).to have_content(@title)
    expect(page).to have_content('Successfully created tutorial!')
  end
  it 'Form must be filled out properly or an error flash will occur' do
    fill_in 'Title', with: ''
    fill_in 'Description', with: ''
    fill_in 'Thumbnail', with: ''

    click_on 'Save'

    expect(current_path).to eq('/admin/tutorials')

    expect(page).to have_content("Title can't be blank, Description can't be blank, and Thumbnail is invalid")
  end
end
