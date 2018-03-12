class Admin::TeachersController < Admin::AdminBaseController
  before_action :set_teacher, except: [:index]

  def index
    @teachers = Teacher.all.order(:id)
  end

  def edit_profile
    @teacher_profile = @teacher.teacher_profile.present? ? @teacher.teacher_profile : @teacher.build_teacher_profile
  end

  def update
    @teacher_profile = @teacher.teacher_profile.present? ? @teacher.teacher_profile : @teacher.build_teacher_profile
    if @teacher_profile.present? && @teacher_profile.update_attributes(permitted_teacher_params)
      flash[:notice] = 'Teacher profile successfully updated.'
      redirect_to admin_teachers_path
    else
      flash[:notice] = 'Something went wrong! Try again later.'
      render :new
    end
  end

  def approve
    if @teacher.present? && @teacher.update_attribute(:approve, true)
      UserMailer.teacher_invitaion_email(@teacher).deliver_now
      flash[:notice] = 'Teacher successfully approved.'
    else
      flash[:notice] = 'Something went wrong! Try again later.'
    end
    redirect_to admin_teachers_path
  end

  def reject
    if @teacher.present? && @teacher.update_attribute(:approve, false)
      flash[:notice] = 'Teacher successfully rejected.'
    else
      flash[:notice] = 'Something went wrong! Try again later.'
    end
    redirect_to admin_teachers_path
  end

  def price
    if request.get?
      @price = Price.new
      @teacher_prices = @teacher.prices if @teacher.prices.present?
    elsif request.post?
      @teacher.prices.destroy_all
      params[:price].each do |k, v|
        @price = @teacher.prices.new(child_time: v[:child_time].to_i, two_days_price: v[:two_days_price], three_days_price: v[:three_days_price], five_days_price: v[:five_days_price])
        if @price.save
          flash[:notice] = 'Teacher availability successfully created.'
        else
          flash[:notice] = 'Something went wrong! Try again later.'
        end
      end
      redirect_to teacher_price_admin_teacher_path(@teacher)
    end
  end

  def teacher_price
    @prices = @teacher.prices
  end

  private
    def permitted_teacher_params
      params.require(:teacher_profile).permit(
        :first_name, :last_name, :street_address,
        :apt_no, :city, :home_phone, :cell_phone,
        :date_of_birth, :language, :work,
        :legal_to_work, :apartment, :floor,
        :condo, :house, :basement_premises, :two_exit,
        :home_smoke, :pet, :vaccine, :goal, :age_range,
        :local_school, :school_name, :comments, :profile_image, :cover_photo,
        children_attributes: [:id, :full_name, :age, :care_by, :_destroy]
      )
    end

    def permmited_price_param
      params.require(:price).permit(
        :child_time, :two_days_price, :three_days_price, :five_days_price
      )
    end

    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

end
