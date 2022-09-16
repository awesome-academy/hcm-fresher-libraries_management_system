class ChangeDataTypeForRequests < ActiveRecord::Migration[6.1]
  def change
    change_column(:requests, :status, :integer)
  end
end
