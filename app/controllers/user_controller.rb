class UserController < ApplicationController
	
	def welcome

	end

	def index
		if session[:level] != nil
			redirect_to :controller=>'user', :action => 'welcome'
		end
	end

	def create
		
		save_user User.new
	end

	def login
		@msg =""
		password = hash params[:password]
		user=User::User.where(:mail =>  params[:mail]).first

		if user == nil
			@msg = "Den benutzer gibt es leider nicht."
		else
			if user.password == password
				session[:level] = user.level
				redirect_to :controller=>'user', :action => 'welcome'
			else
				@msg = "Da war etwas falsch"
			end
		end
	end
	def logout
		session[:level] = nil
		redirect_to :controller=>'user', :action => 'index'
	end
	def update
		id = session[:edit_user]
		user=User::User.where(:_id => id).first
		save_user user
	end

	def delete
	end

	def edit
		@yrs  =  [['Admin',1], ['Autor',2],['Mitglied',3]]
		@user=User::User.where(:_id => params[:id]).first
		session[:edit_user] = @user._id
	end

	def list
		@users = User::User.all
	end

	def hash password
		Digest::SHA1.hexdigest(password)
	end

	def save_user user
		user.name = params[:name]
		user.first_name = params[:first_name]
		user.mail = params[:mail]

		if params[:password] != nil && params[:password] != ""
			user.password = params[:password]
		end
		user.level = params[:level].to_i
		user.active = params[:active] == nil
		user.save!
	end


	def is_logged_in?
		if(session[:level] != nil)
			redirect_to :controller=>'user', :action => 'welcome'
		end
	end
	helper_method :is_logged_in?
end