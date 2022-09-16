class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.string :status
      t.datetime :day_begin
      t.datetime :day_end
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
