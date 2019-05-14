require 'rails_helper'

RSpec.describe 'on the root path' do
  before :each do
    @non_class_tut = create(:tutorial)
    @class_tut = create(:tutorial, classroom: true)
  end

  context 'as a visitor' do
    it 'can only see non-classroom tutorials' do
      visit '/'

      expect(page).to have_link(@non_class_tut.title)
      expect(page).to_not have_link(@class_tut.title)
    end
  end
end
