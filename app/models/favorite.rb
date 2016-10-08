class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  
  validates :user, presence: true
  validates :user_id, uniqueness: { scope: :word_id }
  validates :word, presence: true
end
