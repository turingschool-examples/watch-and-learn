require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :thumbnail}
  end
  describe 'class methods' do
    it '.no_classroom_content' do
      create(:tutorial, classroom: true)
      create(:tutorial, classroom: true)
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)

      tutorials = Tutorial.no_classroom_content

      expect(tutorials.count).to eq(2)
      expect(tutorials).to eq([tutorial_1, tutorial_2])
    end
    it 'deleting a tutorial also deletes that tutorials videos' do
      tut_1 = create(:tutorial)
      create(:video, tutorial: tut_1)
      create(:video, tutorial: tut_1)
      video_3 = create(:video)
      tut_1.destroy

      expect(Video.all).to eq([video_3])
    end
  end
end
