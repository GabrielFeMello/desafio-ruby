class RemoveStringFromStore < ActiveRecord::Migration[5.2]
  def change
    remove_column :stores, :string, :string
  end
end
