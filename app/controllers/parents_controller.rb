class ParentsController < ApplicationController

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
