class Forecast < ApplicationRecord
  validates_presence_of :temperature, :short_forecast, :icon, :number, :temperature_unit, :start_time, :end_time
end
