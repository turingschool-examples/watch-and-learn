# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserNotifierMailer, type: :mailer do
  VCR.use_cassette('mailers/user_invites_github_handle') do
    it 'sends an invite link' do
      invitee = {
        :name=>"William Homer",
        :email=>"friend@example.com"
      }
      user = create(:user, first_name: 'james', last_name: 'smith', active: true, github_token: ENV['GITHUB_TOKEN_J'])
      email = UserNotifierMailer.invite(invitee, user)

      assert_emails 1 do
        email.deliver_now
      end

      expect(['from@example.com']).to eq(email.from)
      expect(['friend@example.com']).to eq(email.to)
      expect('Invitation to Join Turing Tutorials').to eq(email.subject)
      expect(email.body.encoded.gsub(/\r/,""))
        .to have_content(file_fixture('invitation.yml').read.chomp)
    end
  end
end
