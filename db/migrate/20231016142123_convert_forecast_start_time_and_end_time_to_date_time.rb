class ConvertForecastStartTimeAndEndTimeToDateTime < ActiveRecord::Migration[7.1]
  def change
    change_column :forecasts, :start_time, :datetime
    change_column :forecasts, :end_time, :datetime
  end
end
