class ApplicationController < ActionController::Base
  protect_from_forgery

  def menu
    p = PagesController.new
    return p.menu 
  end
  helper_method :menu
  def getKinds(parent)
  	p = PagesController.new
    return p.getKinds parent
  end
  helper_method :getKinds
  def kinds?(parent)
    p = PagesController.new
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


  def menu_options page

    options = ""
    classes = ""
    if !page.public and it_is_allowed? "hidden_page"
      classes="hidden"
    end
    if page.parent == nil or page.parent == "" and  it_is_allowed? "change_order"
      classes = classes +" drag"
      options ='draggable="true"'
    end
    return options + ' class="'+classes+'"'
  end
  helper_method :menu_options
end
