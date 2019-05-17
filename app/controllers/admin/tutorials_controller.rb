# frozen_string_literal: true

module Admin
  # namespaced tutorials controller
  class TutorialsController < Admin::BaseController
    def edit
      @tutorial = Tutorial.find(params[:id])
    end

    def new
      @tutorial = Tutorial.new
    end

    def create
      @tutorial = Tutorial.new(tutorial_params)
      return unless @tutorial.save

      flash[:success] = "#{@tutorial.title} created!"
      redirect_to edit_admin_tutorial_path(@tutorial)
    end

    def update
      tutorial = Tutorial.find(params[:id])
      if tutorial.update(tutorial_params)
        flash[:success] = "#{tutorial.title} tagged!"
      end
      redirect_to edit_admin_tutorial_path(tutorial)
    end

    private

    def tutorial_params
      params.require(:tutorial).permit(:tag_list)
    end
  end
end
