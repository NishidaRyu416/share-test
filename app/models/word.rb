class Word < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  has_many  :favorites, dependent: :destroy
  has_many  :books, dependent: :destroy
  
  def favorite?(user)
    favorites.where(user_id: user.id).exists?# exists?の説明 user.idが一致する人を探す。いたら、true いなかったら false
  end
end
