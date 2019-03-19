require 'rails_helper'
describe DashboardRepoFacade do
  it 'exists' do
    token = {}
    drf = DashboardRepoFacade.new(token)

    expect(drf).to be_a(DashboardRepoFacade)
  end
  describe 'instance methods' do
    describe '#repos' do
      it 'returns five repos' do
        token = {}
        drf = DashboardRepoFacade.new(token)

        drf.repos
      end
    end
  end
end
