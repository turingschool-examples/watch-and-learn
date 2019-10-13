# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'relationships' do
    it { should have_many(:videos) }
  end

  describe 'deleting a tutorial' do
    it "deletes videos when the tutorial is deleted" do
      tutorial = Tutorial.create
      video1 = create(:video, tutorial_id: tutorial.id)

      expect { tutorial.destroy }.to change { Video.count }.by(-1)
    end
  end
  
  describe "class methods" do
    it "can verify that a user has no orders" do
      tutorial = create(:tutorial, title: 'How to Tie Your Shoes', classroom: false)
      tutorial_1 = create(:tutorial, title: 'How to Tie Decorate a Christmas Tree', classroom: true)
      tutorial_2 = create(:tutorial, title: 'How to Make Sushi', classroom: false)
      tutorial_3 = create(:tutorial, title: 'How to Dance', classroom: true)
      tutorial_4 = create(:tutorial, title: 'How to Style Your Hair', classroom: false)
      tutorial_5 = create(:tutorial, title: 'How to Style Your Hair: The Sequel', classroom: false)
      tutorial_6 = create(:tutorial, title: 'How to Style Your Hair 3', classroom: false)
      create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
      create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_1)
      create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_2)
      create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_3)
      create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_4)


    expect(Tutorial.non_classroom_tutorials).to eq([tutorial, tutorial_2, tutorial_4, tutorial_5, tutorial_6])
end
