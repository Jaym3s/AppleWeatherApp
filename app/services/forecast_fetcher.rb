# This is a factory class that can select which API to use to fetch weather
#
# Returns a Forecast object
class ForecastFetcher

  def fetch_for_zip(zip)
    api.fetch_forecast(zip_code: zip)
  end

  private

  def api
    @api ||= OpenWeatherAPI.new
  end
end
