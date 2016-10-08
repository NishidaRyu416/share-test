class TestsController < ApplicationController
  before_action:logged_in_user
  #@@result_ary = []の説明　クラス変数、resultメソッドで使うため、クラス変数は、スコープ範囲が大きい

  def start
    
  end
  
  def ready
    if params['option'] == "japanese"
      @question = 'japanese'
      @answer = 'english'
    else
      @question = 'english'
      @answer = 'japanese'
    end
    @words = current_user.words.sample(10)
    render 'question'
  end

  # def question
  #   #@words = current_user.words.sample(10)
  # end

  def create
    @@result_ary = []
    result = params.to_hash
    
    @answer = result.values.slice(3, params['count'].to_i * 2) 
     #４番目から二つが解答、正解答だからそれ以外を消して解答と正解答を残す。
    question_number = 0 #count 問目

    @answer.each_slice(2) do |answer, right| #each_sliceで二つ引数を取る
      question_number += 1
        @@result_ary << "#{question_number} 問目"
      if answer == right
        @@result_ary << "正解！！"
      else
        @@result_ary << "不正解！！　答えは #{right} です。" 
      end
    end
    redirect_to tests_result_path
  end

  def result
    @result_ary = @@result_ary
    @@result_ary = []
  end
end
