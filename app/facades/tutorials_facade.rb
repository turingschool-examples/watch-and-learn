class TutorialsFacade
  def initialize(data)
    @data = data
  end

  def tutorials
    @data
  end

  def visitor_tutorials
    @data.select do |tutorial|
      !tutorial.classroom?
    end
  end

  def tutorials_partial(user)
    if user != nil
      "user_tutorials.html.erb"
    else
      "visitor_tutorials.html.erb"
    end
  end
end
