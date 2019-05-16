require 'rails_helper'

describe 'dependencies' do
  it 'deletes videos when the associated tutorial is deleted' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    expect { tutorial.destroy }.to change { Video.count }
  end
end
