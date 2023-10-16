class AddIndexToLocationsPostalCode < ActiveRecord::Migration[7.1]
  def change
    add_index :locations, :postal_code
  end
end
