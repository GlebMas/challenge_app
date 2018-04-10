class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.string  :name
      t.string  :code
    end

    add_index :suppliers, :code, unique: true
  end
end
