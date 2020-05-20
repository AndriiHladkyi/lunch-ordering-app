class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :date, :image

  has_one :category

  def image
    object.image.current_path
  end
end
