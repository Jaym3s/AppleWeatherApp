require "rails_helper"

RSpec.describe ForecastFetcher, type: :service do
  let(:zip) { "12345" }
  let(:forecast) { instance_double(Forecast) }
  let(:api) { instance_double(OpenWeatherAPI) }

  subject { described_class.new }

  describe "#fetch_for_zip" do
    before do
      allow(OpenWeatherAPI).to receive(:new).and_return(api)
      allow(api).to receive(:fetch_forecast).with(zip_code: zip).and_return(forecast)
    end

    it "uses the OpenWeatherAPI to fetch the forecast" do
      result = subject.fetch_for_zip(zip)
      expect(api).to have_received(:fetch_forecast).with(zip_code: zip)
      expect(result).to eq(forecast)
    end
  end

  describe "API selection" do
    # TODO: handle API failures & tests here
  end
end

