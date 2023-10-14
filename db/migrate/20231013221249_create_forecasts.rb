class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.text :detailed
      t.integer :temperature
      t.string :short
      t.string :icon
      t.integer :number
      t.string :temperature_unit
      t.date :generated_at
      t.date :start_time
      t.date :end_time
      t.string :name

      t.timestamps
    end
  end
end
