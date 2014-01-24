class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
end

  #belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
   #to capture more descriptive association