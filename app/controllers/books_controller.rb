class BooksController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  def new
    @book=Book.new
  end

  def create
    @book = Word.new(word_params)
    @book.user_id = current_user.id
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
  end

  def destroy
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
    redirect_to root_path if @word.user != current_user
  end
end


