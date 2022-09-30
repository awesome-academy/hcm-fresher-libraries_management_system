class AddNoteToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :note, :string
  end
end
