class Welcome
  def self.logged_in_tutorials(params)
    if params[:tag]
      Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end

  def self.logged_out_tutorials(params)
    if params[:tag]
      Tutorial.not_classroom.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      Tutorial.not_classroom.all.paginate(page: params[:page], per_page: 5)
    end
  end
end
