require 'rails_helper'

describe 'As a visitor' do
  it 'I cant see tutorials marked as classroom content' do
    t1 = create(:tutorial)
    t2 = create(:tutorial)
    t3 = create(:tutorial, classroom: true)

    visit root_path

    expect(page).to have_content(t1.title)
    expect(page).to have_content(t2.title)
    expect(page).to_not have_content(t3.title)
  end
end
