class FixTypeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :transations, :type, :transation_type
  end
end
