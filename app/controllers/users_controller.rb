class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User updated successfully"
      redirect_to articles_path
    else
      render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "User not found"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end