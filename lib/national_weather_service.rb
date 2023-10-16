class NationalWeatherService
  include HTTParty
  base_uri 'api.weather.gov'

  attr_accessor :hourly_forecast_uri, :forecast_uri

  def initialize(latitude, longitude)
    @options = { latitude:, longitude: }
  end

  def get_points
    points_data = JSON.parse(self.class.get("/points/#{@options[:latitude]},#{@options[:longitude]}"),
                             symbolize_names: true)
    @forecast_uri = points_data[:properties][:forecast]
    @hourly_forecast_uri = points_data[:properties][:forecastHourly]
  end

  def get_hourly_forecast
    get_points if @hourly_forecast_uri.nil?
    JSON.parse(self.class.get(@hourly_forecast_uri), symbolize_names: true)
  end

  def get_forecast
    get_points if @forecast_uri.nil?
    JSON.parse(self.class.get(@forecast_uri), symbolize_names: true)
  end
end
