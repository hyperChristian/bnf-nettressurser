class Admin::SessionsController < Admin::ApplicationController
  before_action :authorize, except: [:index, :create]


  def new
    redirect_to admin_dashboard_index_url if current_moderator
  end

  def index
    @moderator = Moderator.find_by(fullname: params[session[:current_moderator_id]])
  end

  def create
  	@moderator = Moderator.find_by(username: params[:usename]).try(:authenticate, params[:password])
  	if @moderator
  		
  		session[:current_moderator_id] = @moderator.id
  		redirect_to admin_moderators_url, notice: @moderator.fullname + ' is logged in'
  	
  	else
  		
  		flash[:alert] = 'There is a problem with your username or password.'
  		render :index

  	end

  end

  def destroy
  	session[:current_moderator_id] = nil
  	redirect_to '/login', notice: 'You have logged out.' 
  end
end
