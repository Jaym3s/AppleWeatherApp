# This is the Open Weather API implementation. See general api usage in BaseAPI.
#
# API Documentation: https://openweathermap.org/current#zip
# Requires `OPENWEATHER_API_KEY` API key, signup here: https://openweathermap.org

class OpenWeatherAPI < BaseAPI
  def build_forecast(response)
    Forecast.new(
      current_temp: response['main']['temp'],
      feels_like: response['main']['feels_like'],
      today_low: response['main']['temp_min'],
      today_high: response['main']['temp_max']
    )
  end

  # NOTE: 2.5 is a deprecated API endpoint, weather by zip code is still supported but will be turned off soon.
  def build_request(zip_code)
    api_key = ENV['OPENWEATHER_API_KEY']
    "https://api.openweathermap.org/data/2.5/weather?zip=#{zip_code},us&appid=#{api_key}&units=metric"
  end
end
