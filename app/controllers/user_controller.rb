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
		name = params[:name]
		first_name = params[:first_name]
		mail = params[:mail]
		
		save_user name, first_name, mail, password
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

	def edit
		@user=User::User.where(:_id => params[:id]).first
	end

	def list
		@users = User::User.all
	end

	def hash password
		Digest::SHA1.hexdigest(password)
	end

	def save_user name, first_name, mail, password
		user = User::User.new(:name => name,
			:first_name => first_name, 
			:mail => mail, 
			:password => password)	

		user.save!
	end

end
