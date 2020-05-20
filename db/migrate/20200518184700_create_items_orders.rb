class CreateItemsOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :items_orders do |t|
      t.belongs_to :item
      t.belongs_to :order
    end
  end
end
