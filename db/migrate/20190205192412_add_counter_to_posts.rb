class AddCounterToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :rates_count, :integer, default: 0, null: false
    add_column :posts, :total_rate, :integer, default: 0, null: false
    add_column :posts, :average_rate, :integer, default: 0, null: false
  end
end
