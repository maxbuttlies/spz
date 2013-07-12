class ApplicationController < ActionController::Base
  protect_from_forgery

	def menu
p = PageController.new
    return p.menu 
	end
  helper_method :menu
  def getKinds(parent)
  	p = PageController.new
    return p.getKinds parent
  end
  helper_method :getKinds
end
