# frozen_string_literal: true

require 'rails_helper'

describe 'An admin user add tutorials' do
  it 'adds a new tutorial' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    click_link 'New Tutorial'

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in 'tutorial[title]', with: 'title 1'
    fill_in 'tutorial[description]', with: 'description 1'
    fill_in 'tutorial[thumbnail]', with: 'https://img-s-msn-com.AACPZnE.img?'

    expect { click_on 'Save' }
      .to change { Tutorial.all.count }.by(1)

    expect(current_path).to eq(tutorial_path(Tutorial.last.id))
    expect(page).to have_content('Successfully created tutorial.')
  end

  it 'gets sad path if tutorial title is already taken' do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial, title: 'taken_title')


    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    click_link 'New Tutorial'

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in 'tutorial[title]', with: "#{tutorial.title}"
    fill_in 'tutorial[description]', with: 'description 1'
    fill_in 'tutorial[thumbnail]', with: 'https://img-s-msn-com.AACPZnE.img?'

    expect { click_on 'Save' }
      .to change { Tutorial.all.count }.by(0)

    expect(page).to have_content('Tutorial title already exists.')
  end
end
