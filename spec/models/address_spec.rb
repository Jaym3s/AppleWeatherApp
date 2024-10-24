require "rails_helper"

RSpec.describe Address, type: :model do
  describe "#parsed_address" do
    context "when a valid address is provided" do
      let(:address) { Address.new(address_string: "123 Main St, Anytown, CO 12345") }

      it "parses the address correctly" do
        parsed = address.parsed_address
        expect(parsed).to be_a(StreetAddress::US::Address)
        expect(parsed.postal_code).to eq("12345")
      end
    end

    context "when an invalid address is provided" do
      let(:address) { Address.new(address_string: "invalid address") }

      it "returns nil for parsed_address" do
        expect(address.parsed_address).to be_nil
      end
    end
  end

  describe "#valid?" do
    context "when the address has a valid postal code" do
      let(:address) { Address.new(address_string: "123 Main St, Anytown, CO 12345") }

      it "returns true" do
        expect(address.valid?).to be true
      end
    end

    context "when the address does not have a postal code" do
      let(:address) { Address.new(address_string: "Invalid Address") }

      it "returns false" do
        expect(address.valid?).to be false
      end
    end
  end

  describe "#postal_code" do
    context "when parsed_address is valid" do
      let(:address) { Address.new(address_string: "456 Elm St, Sometown, CO 67890") }

      it "delegates the postal code to parsed_address" do
        expect(address.postal_code).to eq("67890")
      end
    end

    context "when parsed_address is nil" do
      let(:address) { Address.new(address_string: "Invalid Address") }

      it "returns nil for postal_code" do
        expect(address.postal_code).to be_nil
      end
    end
  end
end

