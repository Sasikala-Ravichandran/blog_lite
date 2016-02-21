class Post < ActiveRecord::Base

  validates_presence_of :title, :description

  belongs_to :user

  has_many :post_categories
  has_many :categories, through: :post_categories

  has_many :comments, dependent: :destroy
  
end
