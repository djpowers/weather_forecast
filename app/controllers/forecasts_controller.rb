class ForecastsController < ApplicationController
  def show
    @forecast = Forecast.find(params[:id])
  end

  def create
    results = Geocoder.search(params[:query])
    latitude, longitude = results.first.coordinates
    return unless latitude && longitude

    @location = Location.find_or_create_by(address: params[:query],
                                           latitude:,
                                           longitude:)

    # National Weather Service Points endpoint (GET)
    uri = URI("https://api.weather.gov/points/#{latitude.truncate(4)},#{longitude.truncate(4)}")

    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Create Request
    req = Net::HTTP::Get.new(uri)

    # Fetch Request
    res = http.request(req)

    # National Weather Service Forecast endpoint (GET)
    forecast_uri = URI(JSON.parse(res.body)['properties']['forecast'])

    # Create Request
    req = Net::HTTP::Get.new(forecast_uri)

    # Fetch Request
    res = http.request(req)

    # Parse first forecast period
    forecast_data = JSON.parse(res.body)
    current_forecast = forecast_data['properties']['periods'][0]

    @forecast = Forecast.new(
      detailed: current_forecast['detailedForecast'],
      temperature: current_forecast['temperature'],
      short: current_forecast['shortForecast'],
      icon: current_forecast['icon'],
      number: current_forecast['number'],
      temperature_unit: current_forecast['temperatureUnit'],
      start_time: current_forecast['startTime'],
      end_time: current_forecast['endTime'],
      name: current_forecast['name']
    )

    if @forecast.save
      redirect_to @forecast
    else
      render new
    end
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end
end
