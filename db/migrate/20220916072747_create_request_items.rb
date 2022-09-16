class CreateRequestItems < ActiveRecord::Migration[6.1]
  def change
    create_table :request_items do |t|
      t.integer :quantity
      t.references :book, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
