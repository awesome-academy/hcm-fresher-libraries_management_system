class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.datetime :dob
      t.string :info

      t.timestamps
    end
  end
end
