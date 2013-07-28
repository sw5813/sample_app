class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_filter :signed_in_user_filter, only: [:new, :create]

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user 
      flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def index
    @per_page = params[:per_page] || User.per_page || 20
    @users = User.paginate( :per_page => @per_page, page: params[:page], order: 'name ASC') 
  end

  def destroy
    user = User.find(params[:id])
    unless current_user?(user)
      user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
  end

  private

    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def signed_in_user_filter
      if signed_in?
        redirect_to root_path, notice: "You already have an account"
      end
    end
end
