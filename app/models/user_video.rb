class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: "video_id"
  belongs_to :user, foreign_key: "user_id"
  has_one :tutorial, through: :video

  def self.bookmarked_videos(user)
    test = select("user_videos.*")
    .includes(video: [:tutorial])
    .where(user: user)

    test.group_by {|video| video.tutorial.title}
  end
end
