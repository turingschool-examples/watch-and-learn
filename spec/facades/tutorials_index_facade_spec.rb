require 'rails_helper'

describe TutorialsIndexFacade do
  it 'exists' do
    tutorials_index_facade = TutorialsIndexFacade.new(nil)

    expect(tutorials_index_facade).to be_a(TutorialsIndexFacade)
  end

  describe '.tutorials' do
    before :each do
      @public_tutorials = create_list(:tutorial, 3)
      @classroom_tutorial = create(:classroom_tutorial)
    end

    it 'returns all tutorials when the user is registered' do
      user = create(:user)

      facade = TutorialsIndexFacade.new(user)

      expect(facade.tutorials.length).to eq(4)
      expect(facade.tutorials).to eq(Tutorial.all)
    end

    it 'returns only non-classroom tutorials when a visitor' do
      facade = TutorialsIndexFacade.new(nil)

      expect(facade.tutorials.length).to eq(3)
      expect(facade.tutorials).to eq(@public_tutorials)
    end
  end
end
