module ParentProfilesHelper
	def checked(area)
		@parent_profile.weekly_schedule.nil? ? false : @parent_profile.weekly_schedule.match(area)
	end
end
