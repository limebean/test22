class EnrollmentsController < ApplicationController
	def new
		@enroll_app = Enrollment.new
	end

	def create
		@enroll_app = Enrollment.new(permitted_enrollment_params)
    if @enroll_app.save
      redirect_to enroll_application_teacher_path(params[:child][:teacher_profile_id]), notice: "success"
    else
      redirect_to partner_path, alert: "Something went wrong! Please try again."
    end
	end

  def show
  end

  private

  def permitted_enrollment_params
    params.require(:enrollment).permit(
      :teacher_profile_id,
      :full_name,
      :age,
      :care_by,
      :date_of_birth,
      :parent_id,
      :place_of_birth,
      :gender,
      :allergies,
      :medication,
      :medical_condition
    )
  end
end
