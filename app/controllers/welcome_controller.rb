class WelcomeController < ApplicationController
  before_action :check_if_teacher_or_admin, only: :index
    def index

    end

    def about_us

    end

    def method_name

    end

    def terms_of_use

    end

    def privacy_policy

    end

    def search
      if params[:q].present?
        @teachers = TeacherProfile.where("city ILIKE ?", "%#{params[:q]}%")
        if @teachers.blank?
          @teachers = TeacherProfile.near("%#{params[:q]}%", 50)
        end
      else
        @teachers = TeacherProfile.all
      end
      @hash = Gmaps4rails.build_markers(@teachers) do |teacher, marker|
        marker.lat teacher.latitude
        marker.lng teacher.longitude
        marker.picture({
          marker_anchor: [40, 58],
          url: ActionController::Base.helpers.asset_path("map_icon.png"),
          width: "45",
          height: "45"
        })
        marker.title teacher.school_name
        marker.infowindow render_to_string(:partial => "/welcome/info", locals: {:teacher => teacher})
      end
    end

    def check_email
      @user = User.find_by(email: params[:email_id])
    end

    def show

    end

  private
    def check_if_teacher_or_admin
        if current_user && (current_user.teacher? || current_user.admin?)
            redirect_to dashboard_path
        end
    end
end
