class ParentsController < ApplicationController
  before_action :authenticate_user!, only: [:school]

  def create
    parent =  Parent.new(permitted_parent_params)
    if parent.save
      sign_in(:user, parent)
      cookies[:pop_up] = "true"
      redirect_to after_sign_in_path_for(current_user), notice: "You are now signed"
    else
      redirect_to teacher_profile_path(params[:teacher_profile]), alert: "Something went wrong! Please try again."
    end
  end

  def login
    user = User.find_for_authentication(email:  params[:email])
    cookies[:pop_up] = "true"
    if user.valid_password?(params[:password])
      sign_in_and_redirect(user, event: :authentication)
    end
  end

  def check_email_availability
    if params[status].present?
      @user = User.find_by_email(params[:user][:email])
    else
      @user = User.find_by_email(params[:user][:email])
      respond_to do |format|
          format.json { render :json => !@user }
      end
    end
  end

  def make_payment

  end


  def dashboard
  end

  def child_birth
  end

  def set_child_admission
    @teacher_profile = TeacherProfile.find(params[:teacher_profile])
  end

  def change_favourite_status
    if(current_user)
      @favourite = current_user.favourites.find_by(teacher_id: params[:teacher_id])
      if @favourite
        @favourite.toggle!(:status)
      else
        @favourite = current_user.favourites.new(teacher_id: params[:teacher_id])
        @favourite.save
      end
    end
  end

  def school
    @teacher = Teacher.includes(:teacher_profile)
  end

  def interest_open_house
    teacher = Teacher.find(params[:teacher_id])
    parent = Parent.find(params[:id])
    UserMailer.interest_for_open_house(teacher, parent).deliver_now
    UserMailer.interest_for_open_house(parent).deliver_now
  end

  private

    def login_params
      params.require(:user).permit(:email, :password, :remember_me)
    end

    def permitted_parent_params
      params.require(:parent).permit(
        :email, :name, :last_name, :password
      )
    end
end
