class EnrollmentController < ApplicationController
	def new
		@enroll_app = Enrollment.new
	end

	def create
	end
end
