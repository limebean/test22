class WelcomeController < ApplicationController
  before_action :check_if_teacher_or_admin, only: :index

    def index;    end

    def about_us;    end

    def terms_of_use;    end

    def privacy_policy;    end

    def faq_home_page;    end

    def search
      available_text = ['child care', 'child-care', 'daycare', 'provider', 'Toronto', 'Ontario', 'Calgary', 'Alberta']
      if params[:q].present? && available_text.exclude?(params[:q])
        @message = 'not found'
      else
        # if params[:q].present?
        #   @teachers = TeacherProfile.where("city ILIKE ?", "%#{params[:q]}%")
        #   if @teachers.blank?
        #     @teachers = TeacherProfile.near("%#{params[:q]}%", 50)
        #   end
        # else
          @teachers = TeacherProfile.all
        # end
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
    end

    def check_email
      @user = User.find_by(email: params[:email_id])
    end

    def show;    end

    def contact_us;    end

    def support
      UserMailer.support_mail(params[:name], params[:email], params[:subject], params[:message_body]).deliver_now
      redirect_back fallback_location: root_path
    end

  private
    def check_if_teacher_or_admin
        if current_user && (current_user.teacher? || current_user.admin?)
            redirect_to dashboard_path
        end
    end
end
