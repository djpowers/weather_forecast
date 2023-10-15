class AddLocationRefToForecasts < ActiveRecord::Migration[7.1]
  def change
    add_reference :forecasts, :location, null: false, foreign_key: true
  end
end
