class Category < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { case_sensitive: false },
                    length: { maximum: 25, minimum: 3 }

  has_many :post_categories
  has_many :posts, through: :post_categories



end
