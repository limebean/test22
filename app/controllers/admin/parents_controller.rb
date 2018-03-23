class Admin::ParentsController < Admin::AdminBaseController
  skip_before_action :ensure_is_admin, only: [:index]
  def index
    @parents = Parent.all
  end

end
