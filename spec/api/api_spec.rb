require "rails_helper"

RSpec.describe "Implementation of BaseAPI" do
  # Define a subclass for testing purposes
  class TestAPI < BaseAPI
    def build_request(zip_code)
      "https://testapi.com/forecast?zip=#{zip_code}"
    end

    def build_forecast(response)
      Forecast.new(current_temp: response.current_temp)
    end
  end

  let(:test_api) { TestAPI.new }
  let(:zip_code) { "12345" }

  describe "#fetch_forecast" do
    context "when API request is successful" do
      before do
        success_response = double(success?: true, current_temp: "72")
        allow(HTTParty).to receive(:get).and_return(success_response)
      end

      it "builds the request URL correctly" do
        expected_url = "https://testapi.com/forecast?zip=#{zip_code}"
        expect(test_api.build_request(zip_code)).to eq(expected_url)
      end

      it "returns a valid forecast object" do
        forecast = test_api.fetch_forecast(zip_code: zip_code)
        expect(forecast).to be_a(Forecast)
        expect(forecast.current_temp).to eq("72")
      end
    end

    context "when API request fails" do
      before do
        failure_response = instance_double(HTTParty::Response, success?: false)
        allow(HTTParty).to receive(:get).and_return(failure_response)
      end

      it "returns a default Forecast object in the failure case" do
        forecast = test_api.fetch_forecast(zip_code: zip_code)
        expect(forecast).to be_a(Forecast)
        expect(forecast.current_temp).to be_nil
      end
    end
  end

  describe "#build_request" do
    it "raises MethodNotImplemented for abstract class" do
      base_api = BaseAPI.new
      expect { base_api.build_request(zip_code) }.to raise_error(BaseAPI::MethodNotImplemented)
    end
  end

  describe "#build_forecast" do
    it "raises MethodNotImplemented for abstract class" do
      base_api = BaseAPI.new
      expect { base_api.build_forecast(nil) }.to raise_error(BaseAPI::MethodNotImplemented)
    end
  end
end

