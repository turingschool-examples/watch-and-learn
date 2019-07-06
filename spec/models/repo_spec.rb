# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repo do
  before :each do
    @repo = Repo.new(
      name: 'repo',
      html_url: 'www.google.com'
    )
  end

  it 'exists' do
    expect(@repo).to be_a Repo
  end
end
