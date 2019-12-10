require "rails_helper"

RSpec.describe ActivationMailer, type: :mailer do
  it 'sends activation email to newly registered user' do
    user = create(:user, first_name: 'Bob', last_name: 'G', email: 'bob@gmail.com')
    mail = ActivationMailer.activate(user)

    mail.subject.should eq("#{user.first_name } please activate your account.")
    mail.to.should eq([user.email])
    mail.from.should eq(['no-reply@david-laura.com'])
  end
end
