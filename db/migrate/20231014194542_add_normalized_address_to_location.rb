class AddNormalizedAddressToLocation < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :normalized_address, :string
    rename_column :locations, :address, :inputted_address
  end
end
