class Forecast < ApplicationRecord
  validates_presence_of :temperature, :short, :icon, :number, :temperature_unit, :start_time, :end_time
  validates_numericality_of :temperature, :number
end
