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

  def dashboard
  end

  def child_birth
  end

  def set_child_admission
    @teacher_profile = TeacherProfile.find(params[:teacher_profile])
  end

  def change_favourite_status
    if(current_user)
      favourites = current_user.favourites.new(teacher_id: params[:teacher_id])
      if favourites.save
        render :js => "window.location = '#{request.referer}'", notice: "Teacher added"
      else
        render :js => "window.location = '#{request.referer}'", notice: "Something went wrong! Please try again."
      end
    else
      redirect_to new_user_session_path, notice: 'Please Login'
    end
  end
  def toggle_favourite_status
    if current_user
      @fav_teacher = current_user.favourites.find_by(teacher_id: params[:teacher_id])
      if @fav_teacher.present?
        @fav_teacher.toggle!(:status)
        #flash[:notice] = "Updated favourite teacher"
      else
        @fav_teacher = current_user.favourites.create(teacher_id: params[:teacher_id])
        #@fav_teacher.toggle!(:status)
        #flash[:notice] = "Teacher added"
      end
    else
      redirect_to new_user_session_path, notice: 'Please Login'
    end
  end

  def school

    @teacher = Teacher.includes(:teacher_profile)
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
