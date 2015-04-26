class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit,:update] #used for authorization
  before_action :correct_user, only: [:edit,:update]
  before_action :admin_user, only: :destroy
  
  
  def new
    @user = User.new
  end
  def index
    @users = User.paginate(page: params[:page])
    
  end
  def show
    @user = User.find(params[:id]) # find() takes an int to get the user record and params[:id] will get the id of user
    @microposts = @user.microposts.paginate(page: params[:page])
    
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email # used or delivery of email
      #log_in @user
      flash[:info] = "Please check your email to activate account !"  
      redirect_to root_url # which is similar to user_url(@user)
    else
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # successful edit
      flash[:success] = "Profile Updated"
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end
  
  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
  end
  
  private
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
    
    def logged_in_user
      if !logged_in?
        store_location
        flash[:danger] = "Please Log in!"
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      if !current_user.admin?
        redirect_to root_url
      end
    end
        
    
end
