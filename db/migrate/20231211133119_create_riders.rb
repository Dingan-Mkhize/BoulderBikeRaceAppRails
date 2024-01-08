class CreateRiders < ActiveRecord::Migration[7.0]
  def change
    create_table :riders do |t|
      t.string :first_name
      t.string :last_name
      t.string :city

      t.timestamps
    end
  end
end
