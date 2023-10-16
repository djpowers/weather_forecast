class ForecastsController < ApplicationController
  def show
    @forecast = Forecast.find(params[:id])
  end

  def create
    @location = Location.find_or_create_by(inputted_address: params[:query])

    # check for existing forecasts within determined zip code
    forecasts_by_zip_in_last_half_hour = Forecast.joins(:location).where(
      location: { postal_code: @location.postal_code }, created_at: 30.minutes.ago..Time.now
    ).order(created_at: :desc)

    # return most recent forecast, if available
    if forecasts_by_zip_in_last_half_hour.present?
      flash[:notice] = 'Forecast data retrieved from cache'
      redirect_to location_forecast_path(
        @location,
        forecasts_by_zip_in_last_half_hour.first
      ) and return
    end

    # set up client to retrieve forecast data from NWS API
    national_weather_service = NationalWeatherService.new(@location.latitude.truncate(4),
                                                          @location.longitude.truncate(4))

    forecast_data = national_weather_service.hourly_forecast
    current_forecast = forecast_data[:properties][:periods].first

    @forecast = Forecast.new(
      detailed: current_forecast[:detailedForecast],
      temperature: current_forecast[:temperature],
      short: current_forecast[:shortForecast],
      icon: current_forecast[:icon],
      number: current_forecast[:number],
      temperature_unit: current_forecast[:temperatureUnit],
      start_time: current_forecast[:startTime],
      end_time: current_forecast[:endTime],
      name: current_forecast[:name],
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
