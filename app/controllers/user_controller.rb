class UserController < ApplicationController
	
def welcome
end

	def index
		if session[:user] != nil
			redirect_to :controller=>'user', :action => 'welcome'
      	end
	end

  def create
  		password = hash params[:password]
		user = User::User.new(:name => params[:name],
			:first_name => params[:first_name], 
			:mail => params[:mail], 
			:password => password)	

		user.save!
  end

  def login
  	@msg =""
  	password = hash params[:password]
  	user=User::User.where(:mail =>  params[:mail]).first

	if user == nil
			@msg = "Den benutzer gibt es leider nicht."
	else
	  	if user.password == password
	  		session[:user] = user
			redirect_to :controller=>'user', :action => 'welcome'
		
		else
			@msg = "Da war etwas falsch"
		end
	end
  end
	def logout
		session[:user] = nil
		redirect_to :controller=>'user', :action => 'index'
	end
  def update
  end

  def delete
  end

  def get
  	User::User.where(:mail =>  params[:mail]).first
  end

  def hash password
  	Digest::SHA1.hexdigest(password)
  end
end
