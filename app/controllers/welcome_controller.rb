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
      @teachers = params[:q].present? ? TeacherProfile.where(postal_code: params[:q]) : TeacherProfile.all
      @hash = Gmaps4rails.build_markers(@teachers) do |teacher, marker|
          marker.lat teacher.latitude
          marker.lng teacher.longitude
          marker.picture({
            marker_anchor: [40, 58],
            url: teacher.profile_image.url,
            width: "32",
            height: "37"
          })
          marker.title teacher.school_name
          marker.infowindow render_to_string(:partial => "/welcome/info", locals: {:teacher => teacher})
        end
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
