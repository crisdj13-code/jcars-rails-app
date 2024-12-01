class ChangeVinToStringInCars < ActiveRecord::Migration[7.2]
  def change
    change_column :cars, :vin, :string
  end
end
