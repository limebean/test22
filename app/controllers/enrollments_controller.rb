class EnrollmentsController < ApplicationController
	def new
		@enroll_app = Enrollment.new
	end

	def create
		@enroll_app = Enrollment.new(permitted_enrollment_params)
    if @enroll_app.save
      redirect_to enrollment_path(@enroll_app), notice: "success"
    else
      redirect_to partner_path, alert: "Something went wrong! Please try again."
    end
	end

  def show
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
end
