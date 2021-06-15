class AddDocumentToRepresentative < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :document, :string
  end
end
