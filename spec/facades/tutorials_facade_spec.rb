require 'rails_helper'

describe TutorialsFacade do
  it 'exists' do
    tutorials = create_list(:tutorial, 5)
    facade = TutorialsFacade.new(tutorials)

    expect(facade).to be_a(TutorialsFacade)
  end

  context 'instance methods' do
    context '#tutorials' do
      it 'returns all tutorials' do
        tutorials = create_list(:tutorial, 5)

        facade = TutorialsFacade.new(tutorials)

        expect(facade.tutorials).to be_a(Array)
        expect(facade.tutorials[0]).to be_a(Tutorial)
        expect(facade.tutorials.count).to eq(5)
      end
    end

    context '#visitor_tutorials' do
      it 'returns all tutorials that are not classroom content' do
        create_list(:tutorial, 5)
        create_list(:tutorial, 5, classroom: true)

        facade = TutorialsFacade.new(Tutorial.all)

        expect(facade.visitor_tutorials).to be_a(Array)
        expect(facade.visitor_tutorials[0]).to be_a(Tutorial)
        expect(facade.visitor_tutorials.count).to eq(5)
      end
    end

    context '#tutorials_partial(user)' do
      context 'for current user' do
        it 'returns user tutorials partial path' do
          user = create(:user)
          tutorials = create_list(:tutorial, 5)

          facade = TutorialsFacade.new(tutorials)

          expect(facade.tutorials_partial(user)).to eq('user_tutorials.html.erb')
        end
      end

      context 'for a visitor' do
        it 'returns visitor tutorials partial path' do
          tutorials = create_list(:tutorial, 5)

          facade = TutorialsFacade.new(tutorials)

          expect(facade.tutorials_partial(nil)).to eq('visitor_tutorials.html.erb')
        end
      end
    end
  end
end
