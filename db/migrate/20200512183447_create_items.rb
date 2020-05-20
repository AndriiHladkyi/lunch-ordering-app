class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.decimal :price, null: false, precision: 8, scale: 2
      t.string :category_id
      t.date :date
      t.text :description

      t.timestamps
    end
  end
end
