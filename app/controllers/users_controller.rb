class UsersController < ApplicationController
  before_action :logged_in_user,except:[:new,:create,:userwords,:favorites]
  before_action :set_params, only: [:show, :edit, :update,:favorites,:userwords]
  before_action :correct_user, only: [:edit, :update ,:favorites]
   
   
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Share-単!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @user.update(user_params )
      flash[:success] = "Completion!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def userwords
    @title = 'user_words'
    @words = @user.words.order('created_at desc')
    @user.favorites.each do | favorite |
      if !@words.include?  favorite.word
        @words << favorite.word
      end
    end
    render 'words'
  end



  def favorites #favoriteの集合体
    @title = 'favorite_words'
    @words = @user.favorite_users.order('created_at desc')
    render 'words'
  end


  private
  def set_params
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:local ,:profile)
  end
  
  def correct_user
    redirect_to root_path if @user != current_user
  end
end
