require 'singleton'

class Rights
	include Singleton

	MENU_BAR = 1
	EDIT_USER = 2
	EDIT_PAGE = 3

	def it_is_allowed? level, view
		if view == MENU_BAR
			return level <= 2
		else			
			return level == 1
		end
	end
end
