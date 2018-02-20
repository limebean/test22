class Admin::TeachersController < ApplicationController
  # before_action :set_admin

  def index
    binding.pry
    @teachers = Teacher.all
     # sign_in(@admin, bypass: true)
  end

  private

  # def set_admin
  #   @admin = Admin.find(params[:id])
  # end

end
