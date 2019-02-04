class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.integer :value, null: false, default: 1
      t.integer :post_id
      t.timestamps
    end
    add_index :rates, :post_id
  end
end
