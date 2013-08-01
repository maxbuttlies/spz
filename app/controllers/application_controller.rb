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
  def kinds?(parent)
    p = PageController.new
    return p.kinds? parent
  end
  helper_method :kinds?

  def it_is_allowed? page
    if session[:level] != nil
      return Rights.instance.it_is_allowed? session[:level].to_i,page
    else
      return false
    end
  end
  helper_method :it_is_allowed?
<<<<<<< HEAD

  def hidden page
    if page.public
      return ""
    else
      return "class=hidden"
    end
  end
   helper_method :hidden
=======
>>>>>>> f1ce33d2ce134de96ef90197e308a0d2ddd45b68
end
