
class PagesController < ApplicationController

  def menu
    @articles = Array.new
    tmp= Page::Page.where('$or' => [{:parent=>''},{:parent=>nil}]).sort(:order,:title) 
   # art.each { |e| 
    #  @articles.push Page::Page.new :id => e.keyword , :title => "test" 
    
    #}
  end

  def menuOrder
    selfKey = params[:self]
    before = params[:before]
    newPos = -1
    pageSelf = Page::Page.where(:keyword => selfKey).first
    pageBefore = Page::Page.where(:keyword => before).first

    pageSelf.order = pageBefore.order;
    pageSelf.save!

    pageBefore.order = pageBefore.order + 1
    pageBefore.save!

    pages = Page::Page.where(
      '$and' => [
        {:order.gt => pageBefore.order},
        {'$or'=> [{:parent=>''},
          {:parent=>nil}]}] )
    test = ""
    pages.each { |e|  
      test = test +e.title
    }
    render text: test
  end

  def list
    @articles = Page::Page.where('$or' => [{:parent=>''},{:parent=>nil}])
  end

  def edit
    @action = "update"
    @method = "put"
    @page=Page::Page.where(:keyword =>  params[:id]).first
    session[:page] = @page._id
  end

  def new 
    @action = "create"
    @method = "post"
    @page = Page::Page.new
    @page.content = Page::Article.new
    respond_to do |format|
      format.html { render :template => "pages/edit.html.erb" }
    end
  end

  def create
    page = Page::Page.new 
    save_page page
    redirect_to :controller=>'pages', :action => 'show' , :id => page.keyword
  end

  def update
    id = session[:page]
    page = Page::Page.where(:_id => id).first
    save_page page
    redirect_to :controller=>'pages', :action => 'show' , :id => page.keyword
  end

  def delete
  end



  def index
    redirect_to :controller=>'pages', :action => 'show', :id =>"home"

  end
  def show
    p=Page::Page.where(:keyword =>  params[:id]).first

    if p.content.is_a?Page::Article      
      @page = p
      @page.content.content = Maruku.new(@page.content.content).to_html
    elsif p.content.is_a?Page::AddIn
      redirect_to :controller=>'users', :action => 'index'
    end
  end

  def save_page page
    page.title = params[:title]
    if params[:id]== nil || params[:id] == ""
     page.keyword = params[:title] 
   else
    page.keyword = params[:id]
  end
  page.order = params[:order]
  page.parent = params[:parent]
  if params[:public] == nil
    page.public = false
  else      
    page.public = true      
  end
  if params[:page_type] == "1"
    article = Page::Article.new( :content=>params[:content])
    page.content = article
  elsif params[:page_type] == "2"
    add_in = Page::AddIn.new( :url=>params[:content])
    page.content = add_in
  end
  page.save! 
end

def getKinds(parent)
  return Page::Page.where(:parent =>parent)
end
helper_method :getKinds
def kinds?(parent)
  if Page::Page.where(:parent =>parent).count > 0
    return true
  else
    return false
  end
end
def getPageType(p)
  if p.content.is_a?Page::Article
    return 1
  elsif p.content.is_a?Page::AddIn
   return 2
 end  
end
helper_method :getPageType

end
