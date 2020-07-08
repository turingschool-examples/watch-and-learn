require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe "#instance_mehtods" do
    it ".order_bookmarks" do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      tutorial1 = Tutorial.create(title: "Dog Training", description: "Don't Be a MoMo", thumbnail: "thumbnail")
      potty = tutorial1.videos.create(title: "Potty Train", position: 2)
      sit = tutorial1.videos.create(title: "Sit Boy", position: 1)
      eat = tutorial1.videos.create(title: "Eat On Your Own", position: 3)
      UserVideo.create(user_id: user.id, video_id: potty.id)
      UserVideo.create(user_id: user.id, video_id: eat.id)
      UserVideo.create(user_id: user.id, video_id: sit.id)

      tutorial2 = Tutorial.create(title: "The Next Adele", description: "Best Singer", thumbnail: "thumbnail")
      vocal = tutorial2.videos.create(title: "Vocal Training", position: 1)
      warm_ups = tutorial2.videos.create(title: "Warm Ups", position: 2)

      UserVideo.create(user_id: user.id, video_id: vocal.id)
      UserVideo.create(user_id: user.id, video_id: warm_ups.id)

      expect(user.order_bookmarks).to eq([sit, potty, eat, vocal, warm_ups])
    end
  end
end
