require 'rails_helper'

RSpec.describe TutorialFacade do
  before :each do
    @tutorial = create(:tutorial)
    @facade = TutorialFacade.new(@tutorial)
  end

  it 'exists' do
    expect(@facade).to be_a(TutorialFacade)
  end

  it 'inherits the traits of a tutorial' do
    @facade.title = @tutorial.title
    @facade.description = @tutorial.description
    @facade.thumbnail = @tutorial.thumbnail
  end

end
