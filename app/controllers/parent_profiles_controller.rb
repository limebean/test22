class ParentProfilesController < ApplicationController
	def new
    @parent_profile = current_user.build_parent_profile
    @parent_profile.children.build
  end

  def create
    @parent_profile = current_user.build_parent_profile(permitted_parent_params)
    if @parent_profile.save
      flash[:notice] = 'Teacher profile successfully created.'
      redirect_to dashboard_path
    else
      flash[:notice] = 'Something went wrong! Try again later.'
      render :new
    end
  end

  def edit; end

  def update
    if @parent_profile.present? && @parent_profile.update_attributes(permitted_parent_params)
      flash[:notice] = 'Teacher profile successfully updated.'
      redirect_to dashboard_path
    else
      flash[:notice] = 'Something went wrong! Try again later.'
      render :edit
    end
  end

  def show
    @prices = @parent_profile.parent.prices
  end
end
