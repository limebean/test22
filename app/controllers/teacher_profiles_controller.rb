class TeacherProfilesController < ApplicationController
  before_action :authenticate_user!
  def new
    binding.pry
    @teacher_profile = TeacherProfile.new
  end

  def create
    binding.pry
  end

end
