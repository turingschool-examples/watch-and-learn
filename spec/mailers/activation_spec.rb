# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserNotifierMailer, type: :mailer do
  it 'sends an activation link' do
    user = create(:user)
    email = UserNotifierMailer.inform(user, 'friend@example.com')

    assert_emails 1 do
      email.deliver_now
    end

    expect(['from@example.com']).to eq(email.from)
    expect(['friend@example.com']).to eq(email.to)
    expect('Please Activate Your Jamesfield Account').to eq(email.subject)
    expect(email.body.encoded).to have_content(file_fixture('activation.yml').read.chomp)
  end
end
