class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.tagged_tutorials(params)
    if params[:tag]
       Tutorial.tagged_with(params[:tag])
               .paginate(page: params[:page], per_page: 5)
     else
       Tutorial.all.paginate(page: params[:page], per_page: 5)
     end
  end

  def self.filter_tutorials(params, user)
    tutorials = tagged_tutorials(params)
    classroom_tutorials(tutorials, user)
  end

  def self.classroom_tutorials(tutorials, user)
    if user
      tutorials
    else
      tutorials.where("classroom = false")
    end
  end
end
