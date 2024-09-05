class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated successfully"
      redirect_to @user
    else
      render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      # Log the user in after signing up
      flash[:notice] = "Welcome to the Blog, #{@user.username}!"
      redirect_to articles_path
    else
      render "new"
    end
  end

  def index
    @users = User.all
  end

  def show
    @articles = @user.articles
    if @user.nil?
      flash[:alert] = "User not found"
      redirect_to users_path
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "User deleted successfully."
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
      if @user != current_user && !current_user.admin?
          flash[:alert] = "You don't have permission to delete."
          redirect_to @user
      end
  end

end