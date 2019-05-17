# frozen_string_literal: true

# facade for admin dashboard
class AdminDashboardFacade
  def tutorials
    Tutorial.all
  end
end
