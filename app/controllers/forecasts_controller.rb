class ForecastsController < ApplicationController
  def show
    @forecast = Forecast.find(params[:id])
    @location = @forecast.location
  end

  def create
    @location = Location.find_or_create_by(inputted_address: params[:query])

    # check for existing forecasts within determined zip code
    recent_forecasts = Forecast.by_zip_from_last_half_hour(@location.postal_code)

    if recent_forecasts.present?
      flash[:notice] = 'Forecast data retrieved from cache'
      redirect_to location_forecast_path(
        @location,
        recent_forecasts.first
      ) and return
    end

    # set up client to retrieve forecast data from NWS API
    national_weather_service = NationalWeatherService.new(@location.latitude.truncate(4),
                                                          @location.longitude.truncate(4))

    hourly_forecast_data = national_weather_service.get_hourly_forecast
    hourly_forecast = hourly_forecast_data[:properties][:periods].first

    forecast_data = national_weather_service.get_forecast
    current_forecast = forecast_data[:properties][:periods].first

    @forecast = Forecast.new(
      detailed: current_forecast[:detailedForecast],
      temperature: hourly_forecast[:temperature],
      short: hourly_forecast[:shortForecast],
      icon: hourly_forecast[:icon],
      number: hourly_forecast[:number],
      temperature_unit: hourly_forecast[:temperatureUnit],
      start_time: hourly_forecast[:startTime],
      end_time: hourly_forecast[:endTime],
      name: hourly_forecast[:name],
      location: @location
    )

    if @forecast.save
      redirect_to location_forecast_path(@location, @forecast)
    else
      render new
    end
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end
end
