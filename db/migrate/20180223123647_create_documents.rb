class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.string :document
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
