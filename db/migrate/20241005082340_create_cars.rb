class CreateCars < ActiveRecord::Migration[7.2]
  def change
    create_table :cars do |t|
      t.string :make
      t.float :price
      t.integer :vin
      t.text :description
      t.integer :year
      t.date :date_arrived
      t.date :date_sold

      t.timestamps
    end
  end
end
