# This controller is parent for all controllers handling the admin area functions
class Admin::AdminBaseController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :ensure_is_admin

end
