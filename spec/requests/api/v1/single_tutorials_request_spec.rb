# frozen_string_literal: true

require 'rails_helper'

describe 'Tutorials API' do
  it 'sends a single tutorial' do
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    create(:video, tutorial_id: tutorial2.id)
    create(:video, tutorial_id: tutorial2.id)

    get "/api/v1/tutorials/#{tutorial1.id}"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:id]).to eq(tutorial1.id)
    expect(parsed[:videos].first[:id]).to eq(video1.id)
    expect(parsed[:videos].last[:id]).to eq(video2.id)
  end
end
