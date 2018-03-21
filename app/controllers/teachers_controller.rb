class TeachersController < ApplicationController
  layout :set_layout
  before_action :authenticate_user!, except: [:show, :new, :create, :set_password, :update_password]
  before_action :authenticate_user!, except: [:show, :new, :create, :set_password, :update_password]
  before_action :set_teacher, only: [ :update_password, :set_password ]
  before_action :ensure_teacher, only: :dashboard

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(permitted_teacher_params)
    if @teacher.save
      @teacher.invitation_token
      redirect_to root_path, notice: "Thanks for register, We are reviewing your application. You will receive an email upon approval of your profile."
    else
      redirect_to partner_path, alert: "Something went wrong! Please try again."
    end
  end

  def show
  end

  def update_password
    if @teacher.update(permitted_teacher_password_params)
      bypass_sign_in(@teacher)
      redirect_to new_teacher_profile_path, notice: 'Your password has been set successfully. You can now update your profile.'
    else
      redirect_to root_path, alert: 'Password could not be set.'
    end
  end

  def dashboard
    unless current_user.teacher_profile.presence
      redirect_to new_teacher_profile_path, notice: 'You need to update your profile!'
    end
  end

  def enroll_modal
  end

  def enroll_application
  end

  def get_price
    teacher = Teacher.find(params[:id])
    redirect_to teacher_profile_path(teacher.teacher_profile) unless request.xhr?
    @prices = Teacher.find(params[:id]).prices
  end

  def get_schedule
    @tour_request = TourRequest.new
    @teacher = Teacher.find(params[:id])
    day = params[:date].to_date.wday == 0 ? 7 : params[:date].to_date.wday
    availabilty = @teacher.availabilities.where(day_index: day)
    if availabilty.present?
      @start_time = availabilty.first.start_time.to_s(:time)
      @end_time = availabilty.first.end_time.to_s(:time)
    end
  end

  def tour_booking
    @teacher = Teacher.find(params[:id])
    tour_request = current_user.tour_requests.new(permitted_tour_request_param)
    @status = tour_request.save ? true : false
  end

  def availability
  end

  def set_availability
    calander_events = JSON.parse(params[:calander_events])
    if calander_events.present?
      current_user.availabilities.destroy_all
      calander_events.each do |ce|
        @availability = current_user.availabilities.new(day_index: ce["week_day"], start_time: ce["hour_from"], end_time: ce["hour_to"])
        if @availability.save
          flash[:notice] = 'Teacher availability successfully created.'
        else
          flash[:notice] = 'Something went wrong! Try again later.'
        end
      end
    end
    redirect_to availability_teacher_path
  end

  def get_availability
    get_availabilities = current_user.availabilities
    availabilities = get_availabilities.map do |availabilitly|
      {
        day_of_week: availabilitly.day_index,
        start_hour: availabilitly.start_time.strftime("%H:%M:%S"),
        end_hour: availabilitly.end_time.strftime("%H:%M:%S")
      }
    end
    render json: availabilities
  end

  def bank_account_detail
    stripe_account_id = current_user.teacher_profile.stripe_account_id
    begin
      @stripe_account_details = Stripe::Account.retrieve(stripe_account_id)
    rescue Exception => e
      redirect_to dashboard_path, alert: e.message
    end
  end

  def bank_account
    unless request.get?
      file = File.new(params[:stripe_verification_file].path) rescue nil
      upload_result = upload_identity(file)
      begin
        stripe_account = Stripe::Account.create({
          type: 'custom',
          country: 'US',
          email: current_user.email,
          legal_entity: {
            type: 'individual',
            first_name: current_user.first_name,
            last_name:  current_user.last_name,
            address: {
              city: params[:address_city],
              state: params[:address_state],
              country: 'US',
              postal_code: params[:address_postal_code],
              line1: params[:address_line1],
            },
            dob: {
              day: params[:birth_date].to_date.day,
              month: params[:birth_date].to_date.month,
              year: params[:birth_date].to_date.year,
            },
            verification: {
              document: upload_result.id,
            },
          },
          external_account: {
            object: 'bank_account',
            country: 'US',
            currency: 'usd',
            account_number: params[:bank_account_number],
            account_holder_name: params[:bank_holder_name],
            routing_number: params[:bank_routing_number],
            account_holder_type: 'individual',
          },

          tos_acceptance: {
            date: Time.now.to_i,
            ip: request.remote_ip,
          }
        })

        current_user.teacher_profile.update_attributes(stripe_account_id: stripe_account.id) if stripe_account.present?
        redirect_to bank_account_detail_teachers_path, notice: 'Stripe account succesfully created'
      rescue Stripe::StripeError => e
        render 'bank_account', alert: e.message
      end
    end
  end

  def set_password
    @teacher
  end

  def accept_child_enrollment
    @enroll = Enrollment.find(params[:id])
    if params[status]
      @enroll.update_attributes(status: params[status])
      UserMailer.make_payment_link(@enroll)
    else
      @enroll.update_attributes(status: params[status])
    redirect_to dashboard_path
  end

  private

    def upload_identity(file)
      Stripe::FileUpload.create(
        {
          purpose: 'identity_document',
          file: file
        },
      )
    end

    def set_teacher
      @teacher ||= Teacher.find_by(invitation_token: params[:token])
    end

    def permitted_teacher_password_params
      params.require(:teacher).permit(
        :password,
        :password_confirmation
      )
    end

    def permitted_tour_request_param
      params.require(:tour_request).permit(
        :tour_date,
        :tour_time,
        :phone,
        :teacher_id
      )
    end

    def permitted_teacher_params
      params[:teacher][:password] = Devise.friendly_token.first(8)
      params.require(:teacher).permit(
        :name,
        :email,
        :telephone_no,
        :postal_code,
        :password
      )
    end

    def set_layout
      case action_name
      when 'dashboard', 'availability', 'bank_account', 'bank_account_detail'
        'admin'
      else
        'application'
      end
    end

    def ensure_teacher
      unless current_user && current_user.teacher?
        redirect_to admin_dashboard_path
      end
    end
end
end
