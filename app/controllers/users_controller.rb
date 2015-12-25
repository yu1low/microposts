class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
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
      redirect_to root_path, alert: "不正なアクセスです！"
    end
  end
  
  def update
    if @user == current_user
      if @user.update(user_params)
        flash[:success] = "ユーザー情報を編集しました"
        redirect_to current_user
      else
        render 'edit'
      end
    else
      redirect_to root_path, alert: "不正なアクセスです！"
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @following_users = @user.following_users.order(created_at: :desc)
  end
  
  def followers
    @user = User.find(params[:id])
    @follower_users = @user.follower_users.order(created_at: :desc)
  end
  
  def index
    @users = User.page(params[:page])
  end
  


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location, :profile, :avatar)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
