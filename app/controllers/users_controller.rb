class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    if @user == current_user
    else
      render 'show'
    end
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to current_user
    else
      render 'edit'
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location, :profile)
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end
end
