class Forecast < ApplicationRecord
  validates_presence_of :temperature, :short, :icon, :number, :temperature_unit, :start_time, :end_time
  validates_numericality_of :temperature, :number

  belongs_to :location

  scope :by_zip_from_last_half_hour, lambda { |postal_code|
    joins(:location).where(
      location: { postal_code: }, created_at: 30.minutes.ago..Time.now
    ).order(created_at: :desc)
  }
end
