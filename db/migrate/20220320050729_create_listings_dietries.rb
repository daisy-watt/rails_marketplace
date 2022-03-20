class CreateListingsDietries < ActiveRecord::Migration[6.1]
  def change
    create_table :listings_dietries do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :dietry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
