require "rails_helper"

RSpec.describe GithubInviterMailer, type: :mailer do
  context '.invite' do
    it 'sends an invitation email with proper format' do
      user = create(:user, first_name: 'Jon', last_name: 'Doe')
      GithubInviterMailer.invite(user, 'smtp://127.0.0.1:1025')
      open_email('smtp://127.0.0.1:1025')
      # Hello <INVITEE_NAME_AS_IT_APPEARS_ON_GITHUB>,
      # <INVITER_NAME_AS_IT_APPEARS_ON_GITHUB> has invited you to join <YOUR_APP_NAME>. You can create an account <here (should be a link to /signup)>.
    end
  end
end
