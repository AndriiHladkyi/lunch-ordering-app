class Order < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items

  before_validation :set_total_price, :set_date
  
  validate :check_items
  validates :items, length: { is: 3 }

  private

  def check_items
    categories_ids = Category.all.map(&:id)
    items_ids = items.map(&:category_id).map(&:to_i).sort

    unless items_ids == categories_ids
      errors.add(:order, "You must choose one item from one category")
    end
  end
  
  def set_total_price
    self.total_price = items.map(&:price).sum
  end

  def set_date
    self.date = Date.today
  end
end
