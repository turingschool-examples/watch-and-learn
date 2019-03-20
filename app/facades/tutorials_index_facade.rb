class TutorialsIndexFacade
  def initialize(user)
    @user = user
  end

  def tutorials
    if @user
      @tutorial ||= Tutorial.all
    else
      @tutorial ||= Tutorial.public_tutorials
    end
  end
end
