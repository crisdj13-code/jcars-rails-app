class CreateToys < ActiveRecord::Migration[7.2]
  def change
    create_table :toys do |t|
      t.timestamps
    end
  end
end
