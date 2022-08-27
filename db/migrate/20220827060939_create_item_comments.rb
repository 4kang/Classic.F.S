class CreateItemComments < ActiveRecord::Migration[6.1]
  def change
    create_table :item_comments do |t|

      t.integer :item_id,     null: false
      t.integer :customer_id, null: false
      t.text :comment,     null: false
      t.float :rate, null: false, default: 0

      t.timestamps
    end
  end
end
