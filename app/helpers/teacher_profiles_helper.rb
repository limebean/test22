module TeacherProfilesHelper
  def choose_option
    [["True", "true"], ["False", "false"]]
  end

  def option_with_na
    level =  [["Yes", "0"], ["No", "1"], ["N/A", "2"]]
  end

end
