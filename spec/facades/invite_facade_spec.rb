require 'rails_helper'

describe InviteFacade do

  it 'exists' do
    invite = InviteFacade.new(nil, nil)

    expect(invite).to be_a(InviteFacade)
  end

  describe '.instance_methods' do

    describe '.to_address' do
      it 'returns the recipients email adress' do
        recipient = { email: "bob@burgers.com"}
        invite = InviteFacade.new(nil, recipient)

        expect(invite.to_address).to eq("bob@burgers.com")
      end
    end

    describe '.to_username' do
      it 'returns the recipients username' do
        recipient = { name: "Sterling Archer"}
        invite = InviteFacade.new(nil, recipient)

        expect(invite.to_username).to eq("Sterling Archer")
      end
    end

    describe '.from_username' do
      it 'returns the senders username' do
        user = create(:user)
        invite = InviteFacade.new(user, nil)

        expected = user.first_name + " " + user.last_name

        expect(invite.from_username).to eq(expected)
      end
    end
  end
end
