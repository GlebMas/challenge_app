class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string  :sku
      t.string  :supplier_code,      index: true
      t.string  :name
      t.text    :additional_field_1
      t.text    :additional_field_2
      t.text    :additional_field_3
      t.text    :additional_field_4
      t.text    :additional_field_5
      t.decimal :price,              precision: 5, scale: 2, default: 0
    end

    add_index :products, :sku, unique: true
  end
end
