class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.date :date
      t.decimal :total_price, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
