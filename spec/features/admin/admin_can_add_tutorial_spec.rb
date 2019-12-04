require 'rails_helper'

RSpec.describe  'As an admin' do
  before(:each) do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'
  end

  it 'I can add a new tutorial' do

    fill_in "tutorial[title]", with: 'Baking - The Basics'
    fill_in "tutorial[description]", with: "Venture with Laura into her kitchen as she shows you the baking basics."
    fill_in "tutorial[thumbnail]", with: 'https://www.1training.org/wp-content/uploads/2019/05/Advanced-Diploma-in-Cake-Baking-and-Ornamenting-460x306.jpg'
    click_button 'Save'

    tutorial = Tutorial.last

    expect(current_path).to eq("/tutorials/#{tutorial.id}")
    expect(page).to have_content('Successfully created tutorial!')
  end

  it "it won't create the tutorial with incomplete fields" do
    click_button 'Save'

    expect(page).to have_content("Title can't be blank, Description can't be blank, and Thumbnail can't be blank")
  end
end
