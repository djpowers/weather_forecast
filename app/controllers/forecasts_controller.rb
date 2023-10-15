class ForecastsController < ApplicationController
  def show
    @forecast = Forecast.find(params[:id])
  end

  def create
    @location = Location.find_or_create_by(inputted_address: params[:query])

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
      name: current_forecast[:name]
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
