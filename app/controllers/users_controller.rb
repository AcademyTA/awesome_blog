class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :require_original_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Hello #{@user.username}. Welcome to Awesome Blog!"
      redirect_to articles_path
    else
      render :new
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully.'
      redirect_to articles_path
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def require_original_user
    if current_user != @user
      flash[:danger] = 'You can only edit your own account.'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
