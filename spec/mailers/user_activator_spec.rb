require "rails_helper"

RSpec.describe UserActivatorMailer, type: :mailer do
  describe "inform" do
    before :each do
      @user = create(:user)

      @subject = "You're almost there!"
      @body = "Welcome! You're registration has been initiated. Please visit"
      @mail = UserActivatorMailer.inform(@user)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq(@subject)
      expect(@mail.to).to eq([@user.email])
    end

    it "renders the body" do
      expect(@mail.parts.first.body.raw_source).to include(@body)
    end

  end
end
