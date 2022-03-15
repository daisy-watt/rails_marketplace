class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.datetime :cooked_on
      t.references :category, null: false, foreign_key: true
      t.text :description
      t.integer :price
      t.boolean :sold, default: false

      t.timestamps
    end
  end
end
