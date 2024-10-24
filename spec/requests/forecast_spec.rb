# spec/requests/home_spec.rb
require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "GET /" do
    it "renders the forecast form" do
      get root_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("enter an address")
    end
  end

  describe "POST /forecasts" do
    let(:valid_address) { "1040 W 6th Ave, Broomfield, CO 80020" }
    let(:invalid_address) { "" }

    context "with valid address" do
      it "accepts the address and returns a successful response" do
        post forecasts_path, params: { address: { address_string: valid_address } }

        expect(response).to redirect_to(forecast_path("80020"))
      end
    end

    context "with invalid address" do
      it "returns an error for missing address" do
        post forecasts_path, params: { address: { address_string: invalid_address } }

        expect(response).to redirect_to(root_path)
        expect(request.flash[:alert]).not_to be_nil
      end
    end
  end

  describe "GET /forecasts/:id" do
    let(:valid_address) { "1040 W 6th Ave, Broomfield, CO 80020" }
    # TODO: Create factory for forecasts
    let(:forecast) do
      Forecast.new(
        address: Address.new(address_string: valid_address)
      )
    end

    context "when forecast exists" do
      before do
        allow(Forecast).to receive(:find).with("80020").and_return(forecast)
      end

      it "renders the forecast show page" do
        get forecast_path(forecast.id)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(forecast.id.to_s)
      end

      it "displays cached status if present" do
        get forecast_path(forecast.id, cached: true)
        expect(response).to have_http_status(:success)
        # TODO: Move to i18n
        expect(response.body).to include("fetched from cache")
      end
    end

    context "when forecast does not exist" do
      it "redirects to the root URL with an alert" do
        get forecast_path(-1)  # Invalid ID
        expect(response).to redirect_to(root_url)
        expect(flash[:alert]).to eq("The forecast you have requested has expired")
      end
    end
  end
end
