class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
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

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end