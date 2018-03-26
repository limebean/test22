class EnrollmentsController < ApplicationController
  before_action :ensure_teacher_has_price, only: [:new]

	def new
		@enroll_app = Enrollment.new
	end

	def create
		@enroll_app = Enrollment.new(permitted_enrollment_params)
    if @enroll_app.save
      redirect_to @enroll_app, notice: "success"
    else
      render :new, alert: "Something went wrong! Please try again."
    end
	end

  def show
    @enrollment = Enrollment.find(params[:id])
    @child = @enrollment.child
  end

  def change_enrollment_status
    @enrollment = Enrollment.find(params[:id])
    @enrollment.toggle!(:status)
    redirect_back fallback_location: root_path
  end

  private

    def permitted_enrollment_params
      params.require(:enrollment).permit(
        :child_id,
        :teacher_id,
        :start_date,
        :weekdays_and_time,
        :other_comments
      )
    end

    def ensure_teacher_has_price
      @teacher_profile = TeacherProfile.find_by(id: params[:teacher][:teacher_profile_id])
      if @teacher_profile && @teacher_profile.teacher.present?
        unless @teacher_profile.teacher.prices.present?
          redirect_to @teacher_profile, alter: "Teacher has not set his price. Please contact us to set his prices."
          return
        end
      end
    end
end
