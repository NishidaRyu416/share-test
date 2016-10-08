class Book < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :user,dependent: :destroy
end
