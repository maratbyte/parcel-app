class CreateParcels < ActiveRecord::Migration[6.1]
  def change
    create_table :parcels do |t|
      t.string :origin
      t.string :destination
      t.integer :weight
      t.integer :height
      t.integer :length
      t.integer :width
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.integer :distance
      t.integer :price

      t.timestamps
    end
  end
end
