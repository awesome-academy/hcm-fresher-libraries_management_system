class ChangeDataTypeBookCategory < ActiveRecord::Migration[6.1]
  def change
    change_column(:books, :category, :integer)
  end
end
