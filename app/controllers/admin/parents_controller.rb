class Admin::ParentsController < Admin::AdminBaseController

  def index
    @parents = Parent.all
  end

end
