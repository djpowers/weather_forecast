class NationalWeatherService
  include HTTParty
  base_uri 'api.weather.gov'

  attr_accessor :hourly_forecast_uri

  def initialize(latitude, longitude)
    @options = { latitude:, longitude: }
  end

  def points
    points_data = JSON.parse(self.class.get("/points/#{@options[:latitude]},#{@options[:longitude]}"))
    @hourly_forecast_uri = points_data['properties']['forecastHourly']
  end

  def hourly_forecast
    points
    JSON.parse(self.class.get(@hourly_forecast_uri))
  end
end
