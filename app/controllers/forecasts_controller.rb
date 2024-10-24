class ForecastsController < ApplicationController
  def new
    @forecast = Forecast.new
  end

  def create
    address = address_from_params

    if address.valid?
      forecast = Forecast.find(address.postal_code)
      if forecast.present?
        redirect_to forecast_path(forecast.id, cached: true)
      else
        # TODO: Background this service call. This blocks waiting for an external API request.
        forecast = ForecastFetcher.new.fetch_for_zip(address.postal_code)
        forecast.address = address
        forecast.save
        redirect_to forecast_path(forecast.id)
      end
    else
      # TODO: move to i18n
      redirect_to root_url, alert: "Address invalid, please provide a complete address"
    end

  end

  def show
    @forecast = Forecast.find(params[:id])
    @cached = params[:cached]
    unless @forecast.present?
      # TODO: move to i18n
      redirect_to root_url, alert: "The forecast you have requested has expired"
    end
  end

  private

  def address_from_params
    Address.new(params.permit(address: [:address_string])[:address])
  end
end
