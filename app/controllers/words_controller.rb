class WordsController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  

  
  def show
  end

  def new
    @word = Word.new
  end
  
  def create
    @word = Word.new(word_params)
    @word.user_id = current_user.id
    if @word.save
      flash[:success] = "success!"
      redirect_to @word 
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @word.update(word_params)
      flash[:success] = "success!"
      redirect_to @word
    else
      render 'edit'
    end
  end
  
  def destroy
    # @words = current_user.words.find_by(id: params[:word_id])
    # return redirect_to userwords_user_path(current_user) if @words.nil?
    @word.destroy
    flash[:success] = "Words deleted"
    redirect_to userwords_user_path(current_user)
  end


  def books
    @title=Word.find(1).book.title
  end


  


  private 
  
  def word_params 
    params.require(:word).permit(:user_id, :title, :japanese, :english,
                                :korean, :chinese ,:image)
  end
  
  def set_params
    @word = Word.find(params[:id])
  end
  
  def correct_user
    #@word = Word.find(params[:id])
    redirect_to root_path if @word.user != current_user
  end
end