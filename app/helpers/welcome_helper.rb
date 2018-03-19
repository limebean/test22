module WelcomeHelper
  def check_favourite id
    favourite = current_user.favourites.find_by(teacher_id: id)
    if favourite && favourite.status
      true
    else
      false
    end
  end
end
