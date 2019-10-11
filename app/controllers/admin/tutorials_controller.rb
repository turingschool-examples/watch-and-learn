# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.create(create_params)
    if @tutorial.save
      flash[:success] = "Sucdessfuly created tutorial"
      redirect_to "/tutorials/#{@tutorial.id}"
    else
      flash[:error] = @tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destory
    redirect_to '/admin/dashboard'
    flash[:success] = 'You have successfully deleted the tutorial'
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def create_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
