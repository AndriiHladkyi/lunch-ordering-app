class OrderSerializer < ActiveModel::Serializer
  attributes :id, :date, :total_price

  has_many :items
  has_one :user
end
