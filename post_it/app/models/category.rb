class Category < ActiveRecord::Base
  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  assign_name_to_slug_column(:name)

end