class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    word = Word.find(params[:word_id])
    favorite = current_user.favorites.build(word: word)
    
    if favorite.save
      flash[:success] = "Success"
      redirect_to :back
    else
      flash[:danger] ="Failure"
      redirect_to :back
    end
  end
  
  def destroy
    favorite = current_user.favorites.find_by(word_id: params[:word_id])
    favorite.destroy if favorite
    flash[:success] = "Success"
    redirect_to :back
  end
end
