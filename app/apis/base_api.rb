# This abstract class defines the shared interface the application will use to interact with weather apis.
# 
# This creates a layer to allow switching API's unintrusive to the code.
class BaseAPI

  # TODO: move this into a logical place so others who wish to write an abstract class can re-use.
  class MethodNotImplemented < StandardError; end

  # This returns a forcast object for the provided zip code
  #
  # TODO: search by lat/long - by zip code is depricated.
  def fetch_forecast(zip_code:)
    response = HTTParty.get(build_request(zip_code))

    # TODO: Extract success/failure/error cases into subclasses as they are API specific.
    # TODO: Handle weather retreival failure specifically (address issues, etc).
    if response.success?
      build_forecast(response)
    else
      failure_case
    end
  end

  # TODO: Return flow control to ForecastFetcher factory in order to select a new API.
  def failure_case
    Forecast.new
  end

  # This method builds the api request that will, upon success, have a response that can be mapped in `build_forecast` below.
  def build_request(zip_code)
    raise MethodNotImplemented
  end

  # This method builds the forcast object from the api response mapping.
  def build_forecast(response)
    raise MethodNotImplemented
  end
end
