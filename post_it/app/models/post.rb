 class Post < ActiveRecord::Base

  include Voteable
  include Sluggable

  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  assign_name_to_slug_column(:title)

end
  #belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
   #to capture more descriptive association

   #str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
   #str.gsub! /-+/,"-"