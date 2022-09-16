class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :describe
      t.string :name
      t.string :publisher
      t.string :category
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
