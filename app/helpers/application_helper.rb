module ApplicationHelper

  def formatted_date(date)
    date.strftime('%d/%m/%Y')
  end

  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end

  def is_active_menu(menu)
    action_name == menu ? "active": nil
  end

  def google_map(center)
    "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=400x600&zoom=17"
  end

  def date_format(date)
    date.strftime("%B  %d, %Y ")
  end

end
