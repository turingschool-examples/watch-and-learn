require 'rails_helper'

RSpec.describe 'on the root path' do
  before :each do
    @non_class_tut = create(:tutorial)
    @non_class_tut2 = create(:tutorial)
    @class_tut = create(:tutorial, classroom: true)
    @class_tut2 = create(:tutorial, classroom: true)
  end

  context 'as a visitor' do
    it 'can only see non-classroom tutorials' do
      visit '/'

      expect(page).to have_link(@non_class_tut.title)
      expect(page).to have_link(@non_class_tut2.title)
      expect(page).to_not have_link(@class_tut.title)
      expect(page).to_not have_link(@class_tut2.title)
    end
  end

  context 'as a logged in user' do
    it 'can see all types of tutorials' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      expect(page).to have_link(@non_class_tut.title)
      expect(page).to have_link(@non_class_tut2.title)
      expect(page).to have_link(@class_tut.title)
      expect(page).to have_link(@class_tut2.title)
    end
  end
end
