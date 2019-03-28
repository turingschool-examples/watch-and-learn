# frozen_string_literal: true

require 'rails_helper'
describe 'An admin deleting a tutorial' do
  it 'also deletes all of its related videos' do
    create(:user, role: 'admin')
    tutorial = create(:tutorial)
    create_list(:video, 4, tutorial: tutorial)
    expect(Video.all.count).to eq(4)
    Tutorial.first.destroy
    expect(Video.all.count).to eq(0)
  end
end
