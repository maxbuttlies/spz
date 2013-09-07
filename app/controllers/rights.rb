require 'singleton'

class Rights
	include Singleton


	RIGHTS = [
		["menu_bar", "new_page", "edit_user", "hidden_page", "edit_page", "change_order"],
		["menu_bar", "new_page",  "hidden_page", "edit_page"]

	]

	def it_is_allowed? level, view
		puts RIGHTS[level.to_i-1]
		puts"----------------------------"
		if RIGHTS[level - 1] != nil and RIGHTS[level - 1].include? view
			return true
		else			
			return level == 1
		end
	end
end
