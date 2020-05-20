class Item < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :category
  has_and_belongs_to_many :orders

  validates :title, :price, :category_id, :date, presence: true
end
