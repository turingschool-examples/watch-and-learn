# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it 'produces no classroom tutorials if user is nil' do
    user = nil

    tutorial1 = create(:tutorial, classroom: false)
    create(:tutorial, classroom: true)

    expect(Tutorial.filtered(user).count).to eq(1)
    expect(Tutorial.filtered(user).first.id).to eq(tutorial1.id)
  end

  it 'produces all tutorials if user is in database' do
    user = create(:user)

    create(:tutorial, classroom: false)
    create(:tutorial, classroom: true)

    expect(Tutorial.filtered(user).count).to eq(2)
  end
end
