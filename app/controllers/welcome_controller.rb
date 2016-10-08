class WelcomeController < ApplicationController
  def index
    @words = Word.all
  end
end
