class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :local, absence: true,
                       on: :create
  validates :local, allow_blank: true, 
                       length: { minimum: 2, maximum: 20 }, 
                       on: :update
                       
  validates :profile, absence: true, #入力を許さない
                       on: :create
  validates :profile, allow_blank: true,  #空文字のときバリデーションスキップ
                       length: { minimum: 2, maximum: 100 }, 
                       on: :update
                       
  has_secure_password
  
  has_many :words

  
  has_many :following_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  has_many :followed_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_users, through: :followed_relationships, source: :follower
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :word
  
  has_many :tests, dependent: :destroy
  has_many :tests_users, through: :favorites, source: :word
  
  has_many :books, dependent: :destroy
  has_many :books_users, through: :books,source: :word


  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end

  #つぶやき取得

#   def feed_items
#     Micropost.where(user_id: following_user_ids + [self.id])
#   end
end


