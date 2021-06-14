class CreateTransations < ActiveRecord::Migration[5.2]
  def change
    create_table :transations do |t|
      t.integer :type
      t.date :date
      t.float :value
      t.references :representative, foreign_key: true
      t.references :store, foreign_key: true
      t.string :card
      t.datetime :time

      t.timestamps
    end
  end
end
