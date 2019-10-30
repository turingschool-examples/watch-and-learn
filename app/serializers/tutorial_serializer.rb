# frozen_string_literal: true

# == Schema Information
#
# Table name: tutorials
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  thumbnail   :string
#  playlist_id :string
#  classroom   :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TutorialSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :thumbnail, :videos

  def videos
    object.videos
  end
end
